// ignore_for_file: prefer_const_constructors

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:panchayat/pages/blocked_users_page.dart';
import 'package:panchayat/themes/theme_provider.dart';
import 'package:provider/provider.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.black,
        elevation: 0,
        title: Text(
          'Settings',
          style: GoogleFonts.lato(
            textStyle: const TextStyle(letterSpacing: 1.95),
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Container(
            margin: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.secondary,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Padding(
              padding: const EdgeInsets.all(13.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  //dark mode
                  Text(
                    'Dark Mode',
                    style: GoogleFonts.prociono(
                      textStyle: TextStyle(letterSpacing: .5, fontSize: 17),
                    ),
                  ),

                  //switch toggle
                  CupertinoSwitch(
                    value: Provider.of<ThemeProvider>(context, listen: false)
                        .isDarkMode,
                    onChanged: (value) =>
                        Provider.of<ThemeProvider>(context, listen: false)
                            .toggleTheme(),
                  )
                ],
              ),
            ),
          ),

          //BLocked Users
          GestureDetector(
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => BlockedUsersPage(),
              ),
            ),
            child: Container(
              margin: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.secondary,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Padding(
                padding: const EdgeInsets.all(13.0),
                child: Text(
                  'Blocked Users',
                  style: GoogleFonts.prociono(
                    textStyle: TextStyle(letterSpacing: .5, fontSize: 17),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
