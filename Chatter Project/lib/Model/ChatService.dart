import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_notebook/Model/ChatUserModel.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ChatService extends ChangeNotifier {

  // get instance of auth and fireStore
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _fireStore = FirebaseFirestore.instance;

  // Send Message
  Future<void> sendMassage({required String receiverId,required String senderName,required String message}) async {
    // get current info of user
    final String currentUserID = firebaseAuth.currentUser!.uid;
    final String currentUserEmail = firebaseAuth.currentUser!.email.toString();
    final Timestamp timestamp = Timestamp.now();


    // create a new message
    Message newMessage = Message(
        senderID: currentUserID,
        senderEmail: currentUserEmail,
        receiverId: receiverId,
        message: message,
        timestamp: timestamp,
        senderName:senderName);

    // construct chat room id from current user id and receiver id
    List<String>ids = [currentUserID, receiverId];
    ids.sort();
    String chatRoomId = ids.join("_");

    // add new message in database
    await _fireStore
        .collection('chatRoom')
        .doc(chatRoomId)
        .collection('message')
        .add(newMessage.toMap());

  }

  // get message
  Stream<QuerySnapshot>getMessage(String userID,otherUserId){
    List<String> ids = [userID,otherUserId];
    ids.sort();
    String chatRoomId = ids.join("_");
    return _fireStore
        .collection('chatRoom')
        .doc(chatRoomId)
        .collection('message')
        .orderBy("timestamp",descending: false)
        .snapshots();

  }

}