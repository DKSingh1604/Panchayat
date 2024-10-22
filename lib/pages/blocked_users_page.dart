import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:panchayat/components/user_tile.dart';
import 'package:panchayat/services/auth/auth_service.dart';
import 'package:panchayat/services/chat/chat_service.dart';

class BlockedUsersPage extends StatelessWidget {
  BlockedUsersPage({super.key});

  //chat and auth service
  final ChatService chatService = ChatService();
  final AuthService authService = AuthService();

  //show confirm unblock box
  void _showUnblockBox(BuildContext context, String userID) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: const Text("Unblock User"),
              content:
                  const Text("Are you sure you want to unblock this user?"),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text("Cancel"),
                ),
                TextButton(
                  onPressed: () {
                    chatService.unblockUser(userID);
                    Navigator.pop(context);
                  },
                  child: const Text("Unblock"),
                )
              ],
            ));
  }

  @override
  Widget build(BuildContext context) {
    //get current users id
    String userID = authService.getCurrentUser()!.uid;

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.black,
        elevation: 0,
        title: Text(
          'Blocked Users',
          style: GoogleFonts.lato(
            textStyle: const TextStyle(letterSpacing: .5),
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
        centerTitle: true,
      ),
      body: StreamBuilder<List<Map<String, dynamic>>>(
        stream: chatService.getBLockedUsersStream(userID),
        builder: (context, snapshot) {
          //errors
          if (snapshot.hasError) {
            return const Center(
              child: Text("Error loading..."),
            );
          }

          //loading...
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          final blockedUsers = snapshot.data ?? [];

          //no users
          if (blockedUsers.isEmpty) {
            return const Center(
              child: Text("No blocked users"),
            );
          }

          //load complete
          return ListView.builder(
            itemCount: blockedUsers.length,
            itemBuilder: (context, index) {
              final user = blockedUsers[index];
              return UserTile(
                text: user["email"],
                onTap: () => _showUnblockBox(
                  context,
                  user['uid'],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
