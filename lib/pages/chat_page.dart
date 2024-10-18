import 'package:flutter/material.dart';
import 'package:panchayat/services/auth/auth_service.dart';
import 'package:panchayat/services/chat/chat_service.dart';

class ChatPage extends StatelessWidget {
  final String receiverEmail;
  final String receiverID;

  ChatPage({
    super.key,
    required this.receiverEmail,
    required this.receiverID,
  });

  //text controller
  final TextEditingController _messageController = TextEditingController();

  //chat and auth services
  final ChatService _chatService = ChatService();
  final AuthService _authService = AuthService();

  //send message
  void sendMessage() async {
    //if there is something in the textfield
    if (_messageController.text.isNotEmpty) {
      //send message
      await _chatService.sendMessage(receiverEmail, _messageController.text);

      //clear textfield
      _messageController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(receiverEmail),
        centerTitle: true,
      ),
      body: Column(
        children: [
          //display messages(majority)
          Expanded(child: _buildMessageList(),),

          //user input
        ],
      ),
    );
  }

  //build message list
  Widget _buildMessageList(){
    String enderID = _authService.getCurrentUser()!uid;
    return StreamBuilder(
      
      builder: ,)
  }
}
