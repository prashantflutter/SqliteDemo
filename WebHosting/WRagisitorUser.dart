import 'package:flutter/material.dart';
import 'package:userform/Modual6/AppConstant/appColors.dart';

class WRegisterPage extends StatefulWidget {
  const WRegisterPage({super.key});

  @override
  State<WRegisterPage> createState() => _WRegisterPageState();
}

class _WRegisterPageState extends State<WRegisterPage> {
  // [{"id":"1","firstname":"Prashant","lastname":"Vadher","email":"p@gmail.com",
  // "phone":"1234567890","city":"Rajkot","gender":"Male","hobbies":"App Development","password":"123456","confirm_password":"123456"}]

  TextEditingController firstnameController = TextEditingController();
  TextEditingController lastnameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirm_passwordController = TextEditingController();

  ValueNotifier valueUpdate = ValueNotifier(0);
  String gender = 'other';
  bool isReading = false;
  bool isPlaying = false;
  bool isWatching = false;
  bool isView = true;
  bool isCView2 = true;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primeColor,
        title: Text('Register User',style: TextStyle(fontSize: 18,color: Colors.white),),
      ),
      body: Padding(
        padding:  EdgeInsets.symmetric(horizontal: size.width*0.05),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding:  EdgeInsets.only(top: size.width*0.05),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: size.width*0.42, child: WTextFiled(controller: firstnameController, hintText: 'First Name')),
                    SizedBox(
                        width: size.width*0.42, child: WTextFiled(controller: lastnameController, hintText: 'Last Name')),
                  ],
                ),
              ),
              WTextFiled(controller: emailController, hintText: 'Email',keyboardType: TextInputType.emailAddress),
              WTextFiled(controller: phoneController, hintText: 'Phone Number',keyboardType: TextInputType.number),
              ValueListenableBuilder(
                valueListenable:valueUpdate,
                builder: (context,value,child) {
                  return Padding(
                    padding: EdgeInsets.symmetric(horizontal: size.width*0.04),
                    child: Row(
                      children: [
                        Text('Gender : ',style: TextStyle(fontSize: 18),),
                      WRadioButton(title: 'Male', value: 'Male', groupValue: gender, onChanged: (value){
                        gender = value!;
                        valueUpdate.value++;
                      }),
                      WRadioButton(title: 'FeMale', value: 'FeMale', groupValue: gender, onChanged: (value){gender = value!;valueUpdate.value++;}),
                      ],
                    ),
                  );
                }
              ),
              ValueListenableBuilder(
                valueListenable:valueUpdate,
                builder: (context,value,child) {
                  return Padding(
                    padding: EdgeInsets.symmetric(horizontal: size.width*0.04),
                    child: Row(
                      children: [
                        Text('Hobbies : ',style: TextStyle(fontSize: 18),),
                        WCheckBox(title: 'Reading', value: isReading, onChanged: (hobby){
                          isReading = hobby!;
                          valueUpdate.value++;
                        }),
                        WCheckBox(title: 'Playing', value: isPlaying, onChanged: (hobby){
                          isPlaying = hobby!;
                          valueUpdate.value--;
                        }),
                        WCheckBox(title: 'Watching', value: isWatching, onChanged: (hobby){
                          isWatching = hobby!;
                          valueUpdate.value++;
                        }),

                      ],
                    ),
                  );
                }
              ),
              WTextFiled(controller: cityController, hintText: 'Address',maxLength: 4),
              WTextFiled(controller: passwordController, hintText: 'Password',suffixIcon:
              IconButton(onPressed: (){
                isView = !isView;
                valueUpdate.value++;
              }, icon: Icon(isView?Icons.visibility:Icons.visibility_off))),
              WTextFiled(controller: confirm_passwordController, hintText: 'Confirm Password',
                  suffixIcon: IconButton(onPressed: (){
                isCView2 = !isCView2;
                // valueUpdate.value++;
              }, icon: Icon(isCView2?Icons.visibility:Icons.visibility_off))),
              Container(
                width: 150,
                padding: EdgeInsets.symmetric(vertical: 20),
                child: ElevatedButton(onPressed: (){},
                    style: ElevatedButton.styleFrom(backgroundColor: primeColor),
                    child: Text('Submit',style: TextStyle(fontSize: 12,color: Colors.white),)),
              )
            ],
          ),
        ),
      ),
    );
  }


  Widget WRadioButton({required String title,required String value,required String groupValue,required void Function(String?)? onChanged}){
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        children: [
          Text(title,),
          Radio(
              value: value,
              groupValue: groupValue,
              onChanged: onChanged,
            activeColor: primeColor,
          ),
        ],
      ),
    );
  }

  Widget WCheckBox({required String title,required bool value,required void Function(bool?)? onChanged}){
    return Container(
      width: 80,
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5.0),
            child: Text(title,),
          ),
          Expanded(
            child: Transform.scale(
              scale: 0.8,
                child: Checkbox(value: value, onChanged: onChanged,activeColor: primeColor,)),
          ),
        ],
      ),
    );
  }

  Widget WTextFiled({required TextEditingController controller,int? maxLength,required String hintText,Widget? prefixIcon,Widget? suffixIcon,bool obscureText = false,TextInputType? keyboardType}){
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        controller: controller,
        cursorColor: primeColor,
        obscureText: obscureText,
        keyboardType: keyboardType,
        maxLines: maxLength,
        decoration: InputDecoration(
          hintText: hintText,
          counterText: '',
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide(color: primeColor),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide(color: primeColor),
          ),
          contentPadding: EdgeInsets.only(left: 15,top: 10),
          prefixIcon: prefixIcon,
          suffixIcon: suffixIcon,
        ),

      ),
    );
  }
}
