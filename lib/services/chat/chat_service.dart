import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:panchayat/models/message.dart';
import 'package:flutter/material.dart';

class ChatService extends ChangeNotifier {
  //get instance of firestore & auth
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  //get all user stream
  Stream<List<Map<String, dynamic>>> getUsersStream() {
    return _firestore.collection("Users").snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        //go through each user
        final user = doc.data();

        //return user
        return user;
      }).toList();
    });
  }

  //GET ALL USERS EXCEPT BLOCKED USERS
  Stream<List<Map<String, dynamic>>> getUsersStreamExcludingBlocked() {
    final currentUser = _auth.currentUser;
    return _firestore
        .collection('Users')
        .doc(currentUser!.uid)
        .collection('BlockedUsers')
        .snapshots()
        .asyncMap((snapshot) async {
      //get list of blocked users ids
      final blockedUserIDs = snapshot.docs.map((doc) => doc.id).toList();

      //get all users
      final userSnapshot = await _firestore.collection('Users').get();

      //return as stream list, excluding current user and blocked user
      return userSnapshot.docs
          .where((doc) =>
              doc.data()['email'] != currentUser.email &&
              !blockedUserIDs.contains(doc.id))
          .map((doc) => doc.data())
          .toList();
    });
  }

  //send message
  Future<void> sendMessage(String receiverID, message) async {
    //get current user info
    final String currentUserID = _auth.currentUser!.uid;
    final String currentUserEmail = _auth.currentUser!.email!;
    final Timestamp timestamp = Timestamp.now();

    //create a new message
    Message newMessage = Message(
      senderID: currentUserID,
      senderEmail: currentUserEmail,
      receiverID: receiverID,
      message: message,
      timestamp: timestamp,
    );

    //construct chat room ID for the two users(sorted to ensure uniqueness)
    List<String> ids = [currentUserID, receiverID];
    ids.sort(); //sort the ids(to ensure the chatroomID is the same for any 2 people)
    String chatRoomID = ids.join('_');

    //add meassge to the database
    await _firestore
        .collection("chat_rooms")
        .doc(chatRoomID)
        .collection("messages")
        .add(newMessage.toMap());
  }

  //get messages stream
  Stream<QuerySnapshot> getMessages(String userID, otherUserID) {
    ///construct chat room ID for the two users(sorted to ensure uniqueness)
    List<String> ids = [userID, otherUserID];
    ids.sort();
    String chatRoomID = ids.join('_');

    return _firestore
        .collection("chat_rooms")
        .doc(chatRoomID)
        .collection("messages")
        .orderBy("timestamp", descending: false)
        .snapshots();
  }

  //REPORT USER
  Future<void> reportUser(String, messageID, String userID) async {
    final currentUser = _auth.currentUser;
    final report = {
      'reportedBy': currentUser!.uid,
      'messageID': messageID,
      'messageOwnerID': userID,
      'timestamp': FieldValue.serverTimestamp(),
    };
    await _firestore.collection('Reports').add(report);
  }

  //BLOCK USER
  Future<void> blockUser(String userID) async {
    final currentUser = _auth.currentUser;
    await _firestore
        .collection('Users')
        .doc(currentUser!.uid)
        .collection('BlockedUsers')
        .doc(userID)
        .set({});
    notifyListeners();
  }

  //UNBLOCK USER
  Future<void> unblockUser(String blockUserID) async {
    final currentUser = _auth.currentUser;

    await _firestore
        .collection('Users')
        .doc(currentUser!.uid)
        .collection('BlockedUsers')
        .doc(blockUserID)
        .delete();
  }

  //GET BLOCKED USER STREAM
  Stream<List<Map<String, dynamic>>> getBLockedUsersStream(String userID) {
    return _firestore
        .collection('Users')
        .doc(userID)
        .collection('BlockedUsers')
        .snapshots()
        .asyncMap((snapshot) async {
      //get list of blocked users ids
      final blockedUserIDs = snapshot.docs.map((doc) => doc.id).toList();

      final userDocs = await Future.wait(
        blockedUserIDs
            .map((id) => _firestore.collection('Users').doc(id).get()),
      );

      //return as a list of maps
      return userDocs.map((doc) => doc.data() as Map<String, dynamic>).toList();
    });
  }
}
