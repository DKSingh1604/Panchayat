// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
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
                child: Center(
                  child: Icon(
                    Icons.message,
                    color: Theme.of(context).colorScheme.primary,
                    size: 70,
                  ),
                ),
              ),

              //home list tile
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: ListTile(
                  leading: Icon(Icons.home, size: 30),
                  title: const Text(
                    "H O M E",
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
                padding: const EdgeInsets.all(20.0),
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
        ],
      ),
    );
  }
}
