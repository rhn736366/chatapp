import 'package:flutter/material.dart';

import '../components/my_button.dart';
import '../components/my_textfield.dart';
import '../service/auth/auth_service.dart';

class RegisterPage extends StatelessWidget {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmpasswordController = TextEditingController();
  final void Function()? onTap;

  RegisterPage({super.key, this.onTap});

  void register(BuildContext context) async {
    final _auth = AuthService();
    if (_passwordController.text == _confirmpasswordController.text) {
      try {
        await _auth.signUpWithEmailPassword(
          _emailController.text,
          _passwordController.text,
          _nameController.text,
        );
      } catch (e) {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(title: Text(e.toString())),
        );
      }
    } else {
      showDialog(
        context: context,
        builder: (context) => const AlertDialog(
          title: Text("Passwords don't match!"),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: colorScheme.background,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 100),

                // logo
                Icon(
                  Icons.message,
                  size: 60,
                  color: colorScheme.inversePrimary,
                ),
                const SizedBox(height: 20),

                // heading
                Text(
                  "Let's create an account",
                  style: TextStyle(color: colorScheme.inversePrimary),
                ),
                const SizedBox(height: 20),

                // name
                MyTextField(
                  hintText: "Name",
                  ObscureText: false,
                  controller: _nameController,
                ),
                const SizedBox(height: 10),

                // email
                MyTextField(
                  hintText: "Email",
                  ObscureText: false,
                  controller: _emailController,
                ),
                const SizedBox(height: 10),

                // password
                MyTextField(
                  hintText: "Password",
                  ObscureText: true,
                  controller: _passwordController,
                ),
                const SizedBox(height: 10),

                // confirm password
                MyTextField(
                  hintText: "Confirm password",
                  ObscureText: true,
                  controller: _confirmpasswordController,
                ),
                const SizedBox(height: 20),

                // register button
                MyButton(text: "Register", onTap: () => register(context)),
                const SizedBox(height: 25),

                // login now
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Already have an account?",
                      style: TextStyle(color: colorScheme.inversePrimary),
                    ),
                    GestureDetector(
                      onTap: onTap,
                      child: Text(
                        " Login now",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: colorScheme.inversePrimary,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
