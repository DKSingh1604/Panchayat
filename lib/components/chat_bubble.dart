import 'package:flutter/material.dart';
import 'package:panchayat/services/chat/chat_service.dart';
import 'package:panchayat/themes/theme_provider.dart';
import 'package:provider/provider.dart';

class ChatBubble extends StatelessWidget {
  final String message;
  final bool isCurrentUser;
  final String messageID;
  final String userID;

  const ChatBubble({
    super.key,
    required this.message,
    required this.isCurrentUser,
    required this.messageID,
    required this.userID,
  });

  //show options
  void _showOptions(BuildContext context, String messageID, String userID) {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return SafeArea(
            child: Wrap(
              children: [
                //report message button
                ListTile(
                  leading: const Icon(Icons.report),
                  title: const Text('Report Message'),
                  onTap: () {
                    //pop the menu
                    Navigator.pop(context);

                    //report message
                    _reportMessage(context, messageID, userID);
                  },
                ),

                //block user button
                ListTile(
                  leading: const Icon(Icons.block),
                  title: const Text('Block User'),
                  onTap: () {
                    //pop the menu
                    Navigator.pop(context);

                    //block user
                    _blockUser(context, userID);
                  },
                ),

                //cancel button
                ListTile(
                  leading: const Icon(Icons.cancel),
                  title: const Text('Cancel'),
                  onTap: () => Navigator.pop(context),
                ),
              ],
            ),
          );
        });
  }

  //report message
  void _reportMessage(BuildContext context, String messageID, String userID) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Report Message"),
        content: const Text("Are you sure you want to report this message?"),
        actions: [
          //cancel button
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancel"),
          ),

          //report button
          TextButton(
            onPressed: () {
              ChatService().reportUser(context, messageID, userID);
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text("Message reported"),
                ),
              );
            },
            child: const Text("Report"),
          ),
        ],
      ),
    );
  }

  //block user
  void _blockUser(BuildContext context, String userID) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Block User"),
        content: const Text("Are you sure you want to block this user?"),
        actions: [
          //cancel button
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancel"),
          ),

          //block button
          TextButton(
            onPressed: () {
              //perform block
              ChatService().blockUser(userID);
              //dismiss the dialog
              Navigator.pop(context);
              //dismiss the chat page of the blocked user
              Navigator.pop(context);

              //let user know the result
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text("User blocked!"),
                ),
              );
            },
            child: const Text("Block"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    bool isDarkMode =
        Provider.of<ThemeProvider>(context, listen: false).isDarkMode;

    return GestureDetector(
      onLongPress: () {
        if (!isCurrentUser) {
          //show options
          _showOptions(context, messageID, userID);
        }
      },
      child: Container(
        padding: const EdgeInsets.all(10),
        margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
        decoration: BoxDecoration(
          color: isCurrentUser
              ? (isDarkMode ? Colors.green.shade600 : const Color(0xFF42A5F5))
              : (isDarkMode
                  ? Colors.grey.shade800
                  : const Color.fromARGB(255, 131, 128, 128)),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Text(
          message,
          style: TextStyle(color: isDarkMode ? Colors.white : Colors.black),
        ),
      ),
    );
  }
}
