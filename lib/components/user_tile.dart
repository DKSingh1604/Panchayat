// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class UserTile extends StatelessWidget {
  final String text;
  final void Function()? onTap;

  const UserTile({
    super.key,
    required this.text,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey[400],
          borderRadius: BorderRadius.circular(12),
        ),
        margin: EdgeInsets.symmetric(
          vertical: 5,
          horizontal: 25,
        ),
        child: Padding(
          padding: const EdgeInsets.all(25.0),
          child: Row(
            children: [
              //icon
              Icon(Icons.person),

              //username
              Text(text),
            ],
          ),
        ),
      ),
    );
  }
}
