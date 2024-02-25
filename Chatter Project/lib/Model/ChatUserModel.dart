import 'package:cloud_firestore/cloud_firestore.dart';

class Message{
  final String senderID;
  final String senderEmail;
  final String receiverId;
  final String message;
  final String senderName;
  final Timestamp timestamp;

  Message(
      {
        required this.senderID,
        required this.senderEmail,
        required this.receiverId,
        required this.message,
        required this.senderName,
        required this.timestamp
      });

  Map<String,dynamic>toMap(){
    return {
      'senderID':senderID,
      'senderEmail':senderEmail,
      'receiverId':receiverId,
      'message':message,
      'senderName':senderName,
      'timestamp':timestamp,
    };
  }
}