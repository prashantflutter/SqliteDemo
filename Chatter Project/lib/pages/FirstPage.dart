import 'package:flutter/material.dart';

import '../AppConstant/appColors.dart';
import '../widgets.dart';
import 'LoginPage.dart';
import 'SignupPage.dart';

class FirstPage extends StatelessWidget {
  const FirstPage({super.key});

  @override
  Widget build(BuildContext context) {
   final size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: size.height*0.15,),
            Icon(Icons.chat,size: 80,color: primeColor,),
            Padding(
              padding: EdgeInsets.only(top: 15),
              child: Text('Chatter',style: TextStyle(color: primeColor,fontSize: 25,fontWeight: FontWeight.bold),),
            ),
            Padding(
              padding: EdgeInsets.only(top: 5),
              child: Text('WORLD\'s MOST PRIVATE CHATTING App',style: TextStyle(color: primeColor,fontSize: 12,fontWeight: FontWeight.normal),),
            ),
            SizedBox(height: size.height*0.2,),
            CustomButton(onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=> LoginPage()));
            },text: 'LOGIN',isRound: false),
            SizedBox(height: 10,),
            CustomButton(onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=> SignupPage()));
            },text: 'SIGNUP'),
            SizedBox(height: size.height*0.2,),
            Text('Made with \u{1F49F} by prashantdeveloper',style: TextStyle(color: primeColor,fontSize: 16,fontWeight: FontWeight.normal),)
          ],
        ),
      ),
    );
  }


}
