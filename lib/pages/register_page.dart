// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:panchayat/services/auth/auth_service.dart';
import 'package:panchayat/components/my_button.dart';
import 'package:panchayat/components/my_textfield.dart';

class RegisterPage extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _pwController = TextEditingController();
  final TextEditingController _confirmPwController = TextEditingController();
  final FocusNode myFocusNode = FocusNode();

  //tap to go to login page
  final void Function()? onTap;

  RegisterPage({super.key, this.onTap});

  //register function
  void register(BuildContext context) async {
    //get auth service
    final auth = AuthService();
    if (_pwController.text == _confirmPwController.text) {
      try {
        auth.signUpWithEmailPassword(
          _emailController.text,
          _pwController.text,
        );
      } catch (e) {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text(e.toString()),
          ),
        );
      }
    }
    //passwords dont match -> tell user to fix
    else {
      showDialog(
        context: context,
        builder: (context) => const AlertDialog(
          title: Text(
            "Passwords don't match!",
            style: TextStyle(
              color: Colors.red,
              fontSize: 20,
            ),
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              //logo
              ClipRect(
                child: Align(
                  alignment: Alignment.center,
                  heightFactor: 0.5,
                  // widthFactor: 0.5,
                  child: Image.asset(
                    'lib/images/logo.png',
                    height: 300,
                    width: 350,
                  ),
                ),
              ),

              const SizedBox(height: 40),

              Text(
                "REGISTER",
                style: GoogleFonts.oswald(
                  textStyle: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
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

              //confirm password textfield
              MyTextField(
                hintText: "Confirm Password",
                controller: _confirmPwController,
                obscureText: true,
                focusNode: myFocusNode,
              ),

              const SizedBox(height: 25),

              //login button
              MyButton(
                text: "Register",
                onTap: () => register(context),
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
      ),
    );
  }
}
