import 'package:flutter/material.dart';
import 'package:panchayat/pages/login_page.dart';
import 'package:panchayat/themes/light_mode.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const LoginPage(),
      theme: lightMode,
    );
  }
}
