import 'package:flutter/material.dart';

class MyTextField extends StatefulWidget {
  final String hintText;
  final bool ObscureText;
  final TextEditingController controller;
  final FocusNode? focusNode;

  const MyTextField({
    super.key,
    required this.hintText,
    required this.ObscureText,
    required this.controller,
    this.focusNode,
  });

  @override
  State<MyTextField> createState() => _MyTextFieldState();
}

class _MyTextFieldState extends State<MyTextField> {
  late bool _obscure;

  @override
  void initState() {
    super.initState();
    _obscure = widget.ObscureText;
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: TextField(
        controller: widget.controller,
        obscureText: _obscure,
        focusNode: widget.focusNode,
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: colorScheme.primary),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: colorScheme.inversePrimary),
          ),
          fillColor: colorScheme.secondary,
          filled: true,
          hintText: widget.hintText,
          hintStyle: TextStyle(
            color: colorScheme.inversePrimary,
          ),
          suffixIcon: widget.ObscureText
              ? IconButton(
            icon: Icon(
              _obscure ? Icons.visibility_off : Icons.visibility,
              color: colorScheme.inversePrimary,
            ),
            onPressed: () {
              setState(() {
                _obscure = !_obscure;
              });
            },
          )
              : null,
        ),
      ),
    );
  }
}
