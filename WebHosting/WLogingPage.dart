import 'package:flutter/material.dart';

class WLoginPage extends StatefulWidget {
  const WLoginPage({super.key});

  @override
  State<WLoginPage> createState() => _WLoginPageState();
}

class _WLoginPageState extends State<WLoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Column(
        children: [

        ],
      ),
    );
  }
}
