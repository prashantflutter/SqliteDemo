import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_notebook/AppConstant/appColors.dart';
import 'package:e_notebook/pages/ChatPage.dart';
import 'package:e_notebook/widgets.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'LoginPage.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  final FirebaseFirestore fireStore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  var senderName;
  void signOut(){
    showModalBottomSheet(context: context, builder: (context) {
      return LogoutDialog(
          context,
          'Are you sure want to logout?',
          sub1: 'Yes', 
          onPressed1: (){
            FirebaseAuth.instance.signOut();
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginPage()));
          },
          sub2: 'No',
      onPressed2: ()=> Navigator.pop(context),);
    });
    
  }



  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop)async {
        if (didPop) return;
        showModalBottomSheet(context: context, builder: (context) {
          return  LogoutDialog(
            context,
            'Are you sure want to exit?',
            sub1: 'Yes',
            onPressed1: ()=> exit(0),
            sub2: 'No',
            onPressed2: ()=> Navigator.pop(context),);
        });
      },
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: primeColor,
          title: Text('Chatter ',style: TextStyle(color: Colors.white),),
          iconTheme: IconThemeData(color: Colors.white),
          actions: [
            IconButton(onPressed: (){
              signOut();
            }, icon: Icon(Icons.logout))
          ],
        ),
        body: _buildUserList(),
      ),
    );
  }

  Widget _buildUserList(){
    return StreamBuilder(stream: fireStore.collection('users').snapshots(),
        builder: (context,documentSnapshot){
          if(documentSnapshot.hasError){
            return Center(child: Text('Something went to wrong!'));
          }
          if(documentSnapshot.connectionState == ConnectionState.waiting){
            return Center(child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('Loading...'),
            ));
          }
          return Padding(
            padding: const EdgeInsets.only(top: 15.0),
            child: ListView(
              children: documentSnapshot.data!.docs.map<Widget>((doc) => _buildUserListItem(doc)).toList(),
            ),
          );
      
        });
  }

  Widget _buildUserListItem(DocumentSnapshot documentSnapshot){
    Map<String,dynamic> data = documentSnapshot.data()! as Map<String,dynamic>;

    if(_auth.currentUser!.email == data['email']){
       senderName = data['name'];
    }

    if(_auth.currentUser!.email != data['email']){
      return ListTile(
        leading: CircleAvatar(child: Icon(Icons.account_circle_outlined,color: primeColor,),),
        title: Text(data['name']),
        onTap: (){
          Navigator.push(context, MaterialPageRoute(builder: (context)=>
              ChatPage(receiverUserEmail: data['name'],receiverUserID: data['uid'], senderName: senderName,)));
        },
      );
    }else{
      return Container();
    }
  }
}
