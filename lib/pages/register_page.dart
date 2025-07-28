// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:panchayat/services/auth/auth_service.dart';
import 'package:panchayat/components/my_button.dart';
import 'package:panchayat/components/my_textfield.dart';

class RegisterPage extends StatefulWidget {
  final void Function()? onTap;

  const RegisterPage({super.key, this.onTap});

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage>
    with SingleTickerProviderStateMixin {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _pwController = TextEditingController();
  final TextEditingController _confirmPwController = TextEditingController();
  final FocusNode myFocusNode = FocusNode();
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );
    _fadeAnimation =
        Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));
    _slideAnimation =
        Tween<Offset>(begin: const Offset(0, 0.5), end: Offset.zero).animate(
            CurvedAnimation(
                parent: _animationController, curve: Curves.easeInOut));
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    _emailController.dispose();
    _pwController.dispose();
    _confirmPwController.dispose();
    myFocusNode.dispose();
    super.dispose();
  }

  //tap to go to login page
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
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [
              Theme.of(context).colorScheme.secondary.withOpacity(0.1),
              Theme.of(context).colorScheme.surface,
              Theme.of(context).colorScheme.primary.withOpacity(0.1),
            ],
          ),
        ),
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24.0),
              child: FadeTransition(
                opacity: _fadeAnimation,
                child: SlideTransition(
                  position: _slideAnimation,
                  child: Card(
                    elevation: 8,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(32.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          //logo with enhanced styling
                          Container(
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Theme.of(context)
                                  .colorScheme
                                  .secondary
                                  .withOpacity(0.1),
                            ),
                            child: ClipRRect(
                              child: Image.asset(
                                'lib/images/logo.png',
                                height: 120,
                                width: 250,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),

                          const SizedBox(height: 25),

                          Text(
                            "REGISTER",
                            style: GoogleFonts.oswald(
                              textStyle: TextStyle(
                                fontSize: 32,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 3,
                                color: Theme.of(context).colorScheme.primary,
                              ),
                            ),
                          ),

                          const SizedBox(height: 10),

                          //welcome message
                          Text(
                            "Let's create an account for you",
                            style: GoogleFonts.exo2(
                              textStyle: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                                color: Theme.of(context)
                                    .colorScheme
                                    .onSurface
                                    .withOpacity(0.7),
                              ),
                            ),
                          ),

                          const SizedBox(height: 35),

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

                          const SizedBox(height: 20),

                          //confirm password textfield
                          MyTextField(
                            hintText: "Confirm Password",
                            controller: _confirmPwController,
                            obscureText: true,
                            focusNode: myFocusNode,
                          ),

                          const SizedBox(height: 35),

                          //register button
                          MyButton(
                            text: "Register",
                            onTap: () => register(context),
                          ),

                          const SizedBox(height: 30),

                          //login now
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Already a member? ",
                                style: GoogleFonts.exo2(
                                  textStyle: TextStyle(
                                    fontSize: 16,
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onSurface
                                        .withOpacity(0.7),
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: widget.onTap,
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8, vertical: 4),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    color: Theme.of(context)
                                        .colorScheme
                                        .primary
                                        .withOpacity(0.1),
                                  ),
                                  child: Text(
                                    "Login Now!",
                                    style: GoogleFonts.exo2(
                                      textStyle: TextStyle(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .primary,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                      ),
                                    ),
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
              ),
            ),
          ),
        ),
      ),
    );
  }
}
