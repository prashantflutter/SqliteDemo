import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../Constant/AppStyle.dart';
import '../Database/database.dart';
import '../Pages/Home_Page.dart';
import '../Constant/AppColors.dart';
import '../Constant/CustomWidgets.dart';

class UserDataEnterPage extends StatefulWidget {
  const UserDataEnterPage({super.key});

  @override
  State<UserDataEnterPage> createState() => _UserDataEnterPageState();
}

class _UserDataEnterPageState extends State<UserDataEnterPage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController descController = TextEditingController();
  TextEditingController dateInputController = TextEditingController();
  TextEditingController timeInputController = TextEditingController();
  String priorityValue = 'Not Mention';

  List<Map<String,dynamic>> userDataList = [];

  Future<void>addData()async{
    await SQLiteDatabase.createData(nameController.text, descController.text,priorityValue, dateInputController.text, timeInputController.text,'');
    _refreshData();
  }

  void _refreshData() async {
    final data = await SQLiteDatabase.getAllData();
    setState(() {
      userDataList = data;
    });
  }
  @override
  void initState() {
    dateInputController.text = "";
    timeInputController.text = "";
    _refreshData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.blue,
        title: Text('User Enter Tasks',style: CustomStyle.AppStyle(color: Colors.white,fontSize: 18)),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: size.width*0.07),
        child: Column(
          children: [
            SizedBox(height: 15,),
            CustomTitle(title: 'Task Name*'),
            CustomTextField(controller: nameController, hintText: 'Enter Task Name',),
            CustomTitle(title: 'Task Description*'),
            CustomTextField(controller: descController, hintText: 'Enter Task Description',maxLines: 4),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Priority : ',style: CustomStyle.AppStyle(color: greyColor,fontSize: 14)),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      CustomRadioButton(
                          title: 'High',
                          value: 'High',
                          groupValue: priorityValue,
                          onChanged: (value){
                            setState(() {
                              priorityValue = value!;
                            });
                          }),
                      CustomRadioButton(
                          title: 'Medium',
                          value: 'Medium',
                          groupValue: priorityValue,
                          onChanged: (value){
                            setState(() {
                              priorityValue = value!;
                            });
                          }),
                      CustomRadioButton(
                          title: 'Low',
                          value: 'Low',
                          groupValue: priorityValue,
                          onChanged: (value){
                            setState(() {
                              priorityValue = value!;
                            });
                          }),
                    ],
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                    width: size.width*0.4,
                    child:CustomDateTimeField(
                        controller: dateInputController,
                        title: 'Date*',
                        prefixIcon: Icon(Icons.calendar_today,color: primeColor,),
                       hintText: "Select Date",
                       onTap: () async {
                        DateTime? pickedDate = await showDatePicker(
                            context: context, initialDate: DateTime.now(),
                            firstDate: DateTime(2000),
                            lastDate: DateTime(2101)
                        );

                        if(pickedDate != null ){
                          print(pickedDate);
                          String formattedDate = DateFormat('dd-MM-yyy').format(pickedDate);
                          print(formattedDate);
                          setState(() {
                            dateInputController.text = formattedDate;
                          });
                        }else{
                          print("Date is not selected");
                        }
                      },
                    )
                ),
                Container(
                    width: size.width*0.4,
                    child:CustomDateTimeField(
                      controller: timeInputController,
                      title: 'Time*',
                      prefixIcon: Icon(Icons.watch_later_outlined,color: primeColor,),
                      hintText: "Select Time",
                      onTap: () async {
                        TimeOfDay? pickedTime =  await showTimePicker(
                          initialTime: TimeOfDay.now(),
                          context: context,
                        );

                        if(pickedTime != null ){
                          print(pickedTime.format(context));
                          DateTime dateTime = DateTime(2022, 1, 1, pickedTime.hour, pickedTime.minute);
                          setState(() {
                            timeInputController.text = DateFormat('h:mm a').format(dateTime);;
                          });
                        }else{
                          print("Time is not selected");
                        }
                      },
                    )
                ),
              ],
            ),
            Container(
              width:  size.width*0.6,
              margin: EdgeInsets.only(top: size.height*0.035),
              child: ElevatedButton(onPressed: (){
                validationCheck();
              },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: primeColor,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),elevation: 1.5),
                  child: Text('Submit',style: CustomStyle.AppStyle(color: Colors.white,),)),
            ),
          ],
        ),
      ),
    );
  }


  void validationCheck(){
    if(nameController.text.isEmpty || descController.text.isEmpty || priorityValue == 'Not Mention' || dateInputController.text.isEmpty || timeInputController.text.isEmpty){
      CustomDialog(context: context, title: 'Please fill all details!',backgroundColor: Colors.redAccent,icon: Icons.error_outline);
    }else{
      addData();
      CustomDialog(context: context, title: 'Successfully added Data...',icon: Icons.file_download_done);
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>HomePage()));
    }
  }


}