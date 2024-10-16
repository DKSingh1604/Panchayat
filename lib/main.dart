import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:panchayat/auth/login_or_register.dart';
import 'package:panchayat/firebase_options.dart';
import 'package:panchayat/pages/register_page.dart';
import 'package:panchayat/themes/light_mode.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const LoginOrRegister(),
      theme: lightMode,
    );
  }
}
