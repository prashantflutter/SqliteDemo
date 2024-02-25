import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_notebook/Model/ChatService.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import '../AppConstant/appColors.dart';
import '../widgets.dart';


class ChatPage extends StatefulWidget {
  final String receiverUserEmail;
  final String receiverUserID;
  final String senderName;

  const ChatPage({Key? key, required this.receiverUserEmail, required this.receiverUserID, required this.senderName}) : super(key: key);

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {

  TextEditingController messageController = TextEditingController();
  ChatService _chatService = ChatService();
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  void sendMessage()async{
    String messageSend = messageController.text;
    if(messageSend.isEmpty){
      showModalBottomSheet(context: context, builder: (context){
        return MyBottomSheetContent(context,'Please enter the message!');
      });
    }else{
      await _chatService.sendMassage(receiverId: widget.receiverUserID, senderName: widget.senderName, message: messageSend,);
      messageController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primeColor,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(widget.receiverUserEmail,style: TextStyle(color:Colors.white,fontSize: 20),),
          ],
        ),
        iconTheme:  IconThemeData(color: Colors.white),
        actions: [
          // Icon(Icons.more_vert)
        ],
      ),
      body: Column(
        children: [
          SizedBox(height: 15,),

          // message
          Expanded(child: _buildMessageList()),

          //input message
          _buildInputMessage(),
        ],
      ),
    );
  }

  //
  Widget _buildMessageList(){
    return StreamBuilder(
        stream: _chatService.getMessage(widget.receiverUserID, firebaseAuth.currentUser!.uid),
        builder: (context,snapShot){
          if(snapShot.hasError){
            return Text('Something went wrong!');
          }
          if(snapShot.connectionState == ConnectionState.waiting){
            return Text('Loading...');
          }
          return ListView(
            children: snapShot.data!.docs.map((doc) => _buildMessageItem(doc)).toList(),
          );
        }
    );
  }

  // build message item
  Widget _buildMessageItem(DocumentSnapshot snapshot){
    Map<String,dynamic> data = snapshot.data() as Map<String,dynamic>;

    var alignment = (data['senderId'] == firebaseAuth.currentUser!.uid)?
    Alignment.centerLeft:
    Alignment.centerRight;
    print('${data['receiverId'].toString()}=== ${firebaseAuth.currentUser!.uid}');

    var crossAxisAlignment = (data['receiverId'] != firebaseAuth.currentUser!.uid)?
    CrossAxisAlignment.end:
    CrossAxisAlignment.start;

    return Container(
      padding:EdgeInsets.symmetric(horizontal: 15,vertical: 5),
      child: Column(
        crossAxisAlignment: crossAxisAlignment,
        children: [
          Text(data['senderName']),
          Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: data['senderId'] == firebaseAuth.currentUser!.uid?Radius.circular(0):Radius.circular(16),
                topRight:data['senderId'] == firebaseAuth.currentUser!.uid? Radius.circular(16):Radius.circular(0),
                bottomLeft: Radius.circular(16),
                bottomRight: Radius.circular(16),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  blurRadius: 2,
                  offset: Offset(0,3)
                ),
              ],
            ),
            child: Text(data['message'],style: TextStyle(color: Colors.blue),),
          ),
        ],
      ),
    );
  }


  // created input build method
  Widget _buildInputMessage(){
    return Row(
      children: [
        Expanded(child: Container(
          margin: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
          padding: EdgeInsets.symmetric(horizontal: 15,vertical: 5),
          decoration: BoxDecoration(
            color: Colors.white,
              borderRadius: BorderRadius.circular(50.0),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                blurRadius: 2,
                offset: Offset(0, 3)
              ),
            ]
          ),
          child: TextFormField(
            controller: messageController,
            minLines: 1,
            maxLines: 2,
            cursorColor: Colors.blue,
            decoration: InputDecoration(
              hintText: 'Enter Message',
              border: InputBorder.none,
            ),
          ),
        ),),
        Container(
            margin: EdgeInsets.only(right: 10,left: 5),
            decoration: BoxDecoration(
                color: Colors.blue,
                boxShadow: [
                  BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      blurRadius: 2,
                      offset: Offset(0, 3)
                  ),
                ],
              borderRadius: BorderRadius.circular(50.0),
            ),
            child: IconButton(onPressed: sendMessage, icon: Icon(Icons.send,color: Colors.white,)))
      ],
    );
  }
}
