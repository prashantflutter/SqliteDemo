import 'dart:io';
import 'package:e_notebook/pages/HomePage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'AppConstant/appColors.dart';
import 'pages/FirstPage.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();

  Platform.isAndroid?
  await Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey: 'AIzaSyBtHjx9-N3cTKNDhshN2nLqrZY81JoKZxE',
          appId: '1:407404893590:android:d8a31cfa866af6636c39b7',
          messagingSenderId: '407404893590',
          projectId: 'e-notebook-21505'),
  ):Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'E-Notebook',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: primeColor),
        useMaterial3: true,
      ),
      home: (FirebaseAuth.instance.currentUser != null)?HomePage():FirstPage(),
    );
  }
}




