import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebasedemo/Firebase%20Demo/NotificationService/NotificationService.dart';
import 'package:firebasedemo/Firebase%20Demo/Pages/HomeScreen.dart';
import 'package:firebasedemo/Firebase%20Demo/Pages/LoginScreen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


import 'Firebase Demo/Pages/PhoneScreen.dart';
import 'Firebase Demo/Provider/CallApi.dart';
import 'Firebase Demo/Provider/DataViewPage.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  // QuerySnapshot snapshot = await FirebaseFirestore.instance.collection('user').get();
  // for(var doc in snapshot.docs){
  //   log(doc.data().toString());
  // }

  // FirebaseFirestore fireStore = FirebaseFirestore.instance;
  //
  // Map<String,dynamic>newUserData = {
  //   'email':'divyesh@gmail.com',
  //   'name' : 'Divyesh'
  // };

  // await fireStore.collection('user').add(newUserData); // Add Value in FirebaseFireStore
  // await fireStore.collection('user').doc('your_id_here').set(newUserData); // Set value with custom ID
  // await fireStore.collection('user').doc('your_id_here').update({'email':'flitzen@gmail.com', 'name' : 'Flitzen'});// Update Value in FireFireStore
  // await fireStore.collection('user').doc('your_id_here').delete(); // Detele Data from FirebaseFireStore


  await NotificationService.initialize();

  runApp(ChangeNotifierProvider(create: (BuildContext context) => UserData(),
  child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: UserDataViewPage(),
      // home: (FirebaseAuth.instance.currentUser != null)?HomeScreen():LoginScreen(),
      // home: (FirebaseAuth.instance.currentUser != null)?HomeScreen(isEmail: false,):PhoneScreen(),
    );
  }
}


