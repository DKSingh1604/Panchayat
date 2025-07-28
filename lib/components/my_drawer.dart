// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:panchayat/services/auth/auth_service.dart';
import 'package:panchayat/pages/settings_page.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  void logout() {
    //get auth service
    final auth = AuthService();
    auth.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.surface,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              //logo
              DrawerHeader(
                child: ClipRect(
                  child: Align(
                    alignment: Alignment.center,
                    heightFactor: 0.9,
                    // widthFactor: 0.5,
                    child: ClipRRect(
                      child: Image.asset(
                        'assets/bg_removed.png',
                        height: 140,
                        width: 220,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              ),

              Text(
                "MENU",
                style: GoogleFonts.oswald(
                  textStyle: TextStyle(
                    fontSize: 25,
                  ),
                ),
              ),

              //home list tile
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: ListTile(
                  leading: Icon(Icons.home, size: 30),
                  title: const Text(
                    "HOME PAGE",
                    style: TextStyle(fontSize: 20),
                  ),
                  onTap: () {
                    //pop the drawer
                    Navigator.pop(context);
                  },
                ),
              ),

              //settings list tile

              Padding(
                padding: const EdgeInsets.all(10.0),
                child: ListTile(
                  leading: Icon(Icons.settings, size: 30),
                  title: const Text(
                    "S E T T I N G S",
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                  onTap: () {
                    //pop the drawer
                    Navigator.pop(context);

                    //navigate to settings page
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SettingsPage(),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),

          //logout tile
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Padding(
              padding: const EdgeInsets.only(left: 20.0),
              child: ListTile(
                leading: Icon(Icons.logout_sharp, size: 30),
                title: const Text(
                  "L O G O U T",
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
                onTap: logout,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
