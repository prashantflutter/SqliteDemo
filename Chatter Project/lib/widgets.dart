import 'package:flutter/material.dart';
import 'AppConstant/appColors.dart';

class MyBottomSheetContent extends StatelessWidget {
  final String title;
  final bool isSuc;
  final BuildContext parentContext;

  MyBottomSheetContent(this.parentContext, this.title, {this.isSuc = false});

  @override
  Widget build(BuildContext context) {

    Future.delayed(Duration(seconds: 2), () {
      Navigator.pop(parentContext);
    });

    return Container(
      width: double.infinity,
      height: 120,
      color: primeColor,
      child: Row(
        children: [
          SizedBox(width: 20,),
          isSuc?Icon(Icons.done,size: 50,color: Colors.white,):
          Icon(Icons.report,size: 50,color: Colors.white,),
          SizedBox(width: 20,),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20,),
              isSuc== false?Text('Uh oh!',style: TextStyle(color: Colors.white,fontSize: 30,),):
              Text('Congratulations...',style: TextStyle(color: Colors.white,fontSize: 30,),),
              Text(title,style: TextStyle(color: Colors.white,fontSize: 16,),),
            ],
          )
        ],
      ),
    );
  }
}



class LogoutDialog extends StatelessWidget {
  final String title;
  final String sub1;
  final String sub2;
  final BuildContext context;
  final void Function()? onPressed1;
  final void Function()? onPressed2;

  LogoutDialog(this.context, this.title, { required this.sub1, required this.sub2,this.onPressed1,this.onPressed2});

  @override
  Widget build(BuildContext context) {

    return Container(
      width: double.infinity,
      height: 180,

      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(25),
          topRight: Radius.circular(25),
        )
      ),
      child: Column(
        // mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 35,
            height: 3,
            margin: EdgeInsets.only(bottom: 15,top: 10),
              decoration: BoxDecoration(
                  color: primeColor,
                  borderRadius: BorderRadius.circular(16)
              )
          ),
          Text(title,textAlign: TextAlign.center,style: TextStyle(color:primeColor,fontSize: 25,fontWeight: FontWeight.w500),),
          SizedBox(height: 20,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              CustomButton(onPressed:onPressed1,text: sub1,width: 120),
              CustomButton(onPressed:onPressed2,text: sub2,width: 120),
            ],
          )
        ],
      ),
    );
  }
}
Widget CustomButton({required void Function()? onPressed,double height = 50,double width = 206,bool isRound = true,String text = ''}){
  return Container(
    width: width,
    height: height,
    child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
            backgroundColor: isRound?primeColor:null,
            side: isRound?null:BorderSide(
              color: primeColor,
            )
        ),
        child: Text(text,style: TextStyle(color: isRound?Colors.white:primeColor,),)),
  );
}


Widget CustomTextField({required TextEditingController controller,bool obscureText = false,required String hintText,Widget? prefixIcon}){
  return TextFormField(
    controller: controller,
    cursorColor: primeColor,
    obscureText: obscureText,
    decoration: InputDecoration(
      hintText: '  $hintText',
      hintStyle: TextStyle(color: Colors.black26),
      prefixIcon: prefixIcon,
      filled: true,
      fillColor: Colors.white,
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(50),
        borderSide: BorderSide(color: Colors.black.withOpacity(0.1),width: 0.2),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(50),
        borderSide: BorderSide(color: Colors.white),
      ),
    ),
  );
}

Widget ChatBox({bool isLeft = true,required String data,required String userName}){
  return Container(
    width: double.infinity,
    child:  Column(
      crossAxisAlignment: isLeft?CrossAxisAlignment.start:CrossAxisAlignment.end,
      mainAxisAlignment: isLeft?MainAxisAlignment.start:MainAxisAlignment.end,
      children: [
        Container(width: double.infinity,margin: isLeft?EdgeInsets.only(left: 10):EdgeInsets.only(right: 10),
            child: Text(userName,textAlign: isLeft?TextAlign.start:TextAlign.end,)),
        Container(
          width: 280,
          alignment: isLeft?Alignment.centerLeft:Alignment.centerRight,
          padding: EdgeInsets.symmetric(horizontal: 15,vertical: 15),
          margin: isLeft?EdgeInsets.only(left: 10):EdgeInsets.only(right: 10),
          decoration: BoxDecoration(
              color: isLeft?Colors.white:Colors.blue,
              borderRadius: BorderRadius.only(
                topLeft: isLeft?Radius.circular(0):Radius.circular(50),
                topRight: isLeft?Radius.circular(50):Radius.circular(0),
                bottomLeft: Radius.circular(50),
                bottomRight: Radius.circular(50),
              ),
              boxShadow: [
                BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    blurRadius: 2,
                    offset: Offset(0, 4)
                )
              ]
          ),
          child: Text(data,textAlign: isLeft?TextAlign.start:TextAlign.end,style: TextStyle(color: isLeft?Colors.blue:Colors.white,fontSize: 16),),

        )
      ],
    ),
  );
}
