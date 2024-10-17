// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:panchayat/auth/auth_service.dart';
import 'package:panchayat/components/my_drawer.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Center(
          child: const Text(
            "Home Page",
          ),
        ),
      ),
      drawer: MyDrawer(),
    );
  }
}
