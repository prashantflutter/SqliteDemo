import 'package:e_notebook/pages/HomePage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../AppConstant/appColors.dart';
import '../widgets.dart';
import 'SignupPage.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();


  void login()async{

    String email = emailController.text.trim();
    String password = passwordController.text.trim();

    if(email.isEmpty || password.isEmpty ){
      showModalBottomSheet(context: context, builder: (context){
        return MyBottomSheetContent(context,'Please fill email & password!');
      });
    }else{
      try{
        UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);
        if(userCredential.user != null){
          showModalBottomSheet(context: context, builder: (context) {
            return MyBottomSheetContent(context, 'Successfully signup...',isSuc: true,);
          });

          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomePage()));
        }
      } on FirebaseAuthException catch(ex){
    showModalBottomSheet(context: context, builder: (context) {
    return MyBottomSheetContent(context,ex.code.toString().replaceAll(RegExp('[-_]'), ' '));
    });
    }
    }
  }

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
            SizedBox(height: size.height*0.1,),
            Icon(Icons.chat,size: size.height*0.14,color: primeColor,),
            Padding(
              padding: EdgeInsets.only(top: 15),
              child: Text('Chatter',style: TextStyle(color: primeColor,fontSize: 28,fontWeight: FontWeight.bold),),
            ),
            SizedBox(height: size.height*0.05,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30,vertical: 8),
              child: CustomTextField(
                  controller: emailController, 
                  hintText: 'Email',
                  prefixIcon: Padding(padding:  EdgeInsets.only(left: 15),
                  child: Icon(Icons.email,color: primeColor,),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30,vertical: 8),
              child: CustomTextField(
                  controller: passwordController,
                  hintText: 'Password',
                  obscureText: true,
                  prefixIcon: Padding(padding:  EdgeInsets.only(left: 15),
                  child: Icon(Icons.lock,color: primeColor,),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 30),
              child: CustomButton(onPressed: (){
                login();
              },text: 'LOGIN'),
            ),
            Padding(
              padding:  EdgeInsets.only(top: 10),
              child: InkWell(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=> SignupPage()));
                },
                  child: Text('or create an account',style: TextStyle(color: primeColor,fontSize: 16,fontWeight: FontWeight.normal),)),
            ),
            SizedBox(height: size.height*0.1,),
            Text('Made with \u{1F49F} by prashantdev',style: TextStyle(color: primeColor,fontSize: 16,fontWeight: FontWeight.normal),),
          ],
        ),
      ),
    );
  }

}
