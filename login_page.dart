import 'package:chatapp/components/my_button.dart';
import 'package:chatapp/components/my_textfield.dart';
import 'package:flutter/material.dart';
import '../service/auth/auth_service.dart';

class LoginPage extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final void Function()? onTap;

  LoginPage({super.key, required this.onTap});

  void login(BuildContext context) async {
    final authService = AuthService();

    try {
      await authService.signInWithEmailPassword(
        _emailController.text,
        _passwordController.text,
      );
    } catch (e) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(title: Text(e.toString())),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: colorScheme.background,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // logo
            Icon(
              Icons.message,
              size: 60,
              color: colorScheme.inversePrimary,
            ),
            const SizedBox(height: 20),

            // login text
            Text(
              "Welcome back, you have been missed!!",
              style: TextStyle(color: colorScheme.inversePrimary),
            ),
            SizedBox(height: 20),

            // email text field
            MyTextField(
              hintText: "Email",
              ObscureText: false,
              controller: _emailController,
            ),
            SizedBox(height: 10),

            // password text field
            MyTextField(
              hintText: "Password",
              ObscureText: true,
              controller: _passwordController,
            ),
            SizedBox(height: 10),

            // login button
            MyButton(text: "Login", onTap: () => login(context)),
            SizedBox(height: 25),

            // register now
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Not a memeber?",
                  style: TextStyle(color: colorScheme.inversePrimary),
                ),
                GestureDetector(
                  onTap: onTap,
                  child: Text(
                    " Register now",
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
    );
  }
}
