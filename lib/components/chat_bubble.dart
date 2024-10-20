import 'package:flutter/material.dart';

class ChatBubble extends StatelessWidget {
  final String message;
  final bool isCurrentUser;
  const ChatBubble({
    super.key,
    required this.message,
    required this.isCurrentUser,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      margin: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: isCurrentUser
            ? Colors.blue
            : const Color.fromARGB(255, 237, 80, 80),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Text(message),
    );
  }
}
