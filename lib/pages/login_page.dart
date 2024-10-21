// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:panchayat/services/auth/auth_service.dart';
import 'package:panchayat/components/my_button.dart';
import 'package:panchayat/components/my_textfield.dart';

class LoginPage extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _pwController = TextEditingController();
  final FocusNode myFocusNode = FocusNode();

  //tap to go to register page
  final void Function()? onTap;

  LoginPage({super.key, this.onTap});

  //login function
  void login(BuildContext context) async {
    //auth service
    final authService = AuthService();

    //try login
    try {
      await authService.signInWithEmailPassword(
        _emailController.text,
        _pwController.text,
      );
    } catch (e) {
      //show error
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text(e.toString()),
        ),
      );
    }

    //catch any errors
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //logo
            Icon(
              Icons.message,
              size: 80,
              color: Theme.of(context).colorScheme.primary,
            ),

            const SizedBox(height: 20),

            //welcome back message
            Text(
              "Welcome Back , you've been missed!",
              style: GoogleFonts.exo2(
                textStyle: TextStyle(
                  fontSize: 19,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            const SizedBox(height: 20),

            //email textfield
            MyTextField(
              hintText: "Email",
              controller: _emailController,
              obscureText: false,
              focusNode: myFocusNode,
            ),

            const SizedBox(height: 20),

            //password textfield
            MyTextField(
              hintText: "Password",
              controller: _pwController,
              obscureText: true,
              focusNode: myFocusNode,
            ),

            const SizedBox(height: 25),

            //login button
            MyButton(
              text: "Login",
              onTap: () => login(context),
            ),

            const SizedBox(height: 15),

            //register now
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Not a member? "),
                GestureDetector(
                  onTap: onTap,
                  child: Text(
                    " Register Now!",
                    style: TextStyle(
                      color: const Color.fromARGB(255, 3, 61, 250),
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
