// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:panchayat/components/my_button.dart';
import 'package:panchayat/components/my_textfield.dart';

class RegisterPage extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _pwController = TextEditingController();

  //tap to go to login page
  final void Function()? onTap;

  RegisterPage({super.key, this.onTap});

  //register function
  void register() {}

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
              "Let's create an account for you",
              style: GoogleFonts.exo2(
                textStyle: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            const SizedBox(height: 20),

            //email textfield
            MyTextField(
              hintText: "Email",
              controller: _emailController,
            ),

            const SizedBox(height: 20),

            //password textfield
            MyTextField(
              hintText: "Password",
              controller: _pwController,
            ),

            const SizedBox(height: 25),

            //confirm password textfield
            MyTextField(
              hintText: "Confirm Password",
              controller: _pwController,
            ),

            const SizedBox(height: 25),

            //login button
            MyButton(
              text: "Register",
              onTap: register,
            ),

            const SizedBox(height: 15),

            //register now
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Already a member? "),
                GestureDetector(
                  onTap: onTap,
                  child: Text(
                    " Login Now!",
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
