import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'db.dart';
//import 'package:sqflitedb/main.dart';


class AddData extends StatefulWidget {
  const AddData({Key? key, required email}) : super(key: key);

  @override
  State<AddData> createState() => AddDataState();
}
class AddDataState extends State<AddData> {
  TextEditingController name = TextEditingController();
  TextEditingController surname = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController address = TextEditingController();
  TextEditingController pincode = TextEditingController();
  TextEditingController city = TextEditingController();
  TextEditingController totalFees = TextEditingController();
  TextEditingController contact = TextEditingController();
  TextEditingController marks = TextEditingController();

  late Mydb mydb = Mydb();

  List<String> courses = ['BCA', 'BBA', 'BA'];
  List<String> cities = ['Rajkot', 'Surat', 'Ahmedabad'];
  String? selectedCourse ;
  String? selectedCity ;

  @override
  void initState() {
    super.initState();
    mydb.open();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Add Details"),),
      body: Container(
        padding: EdgeInsets.all(30),
        child: Column(
          children: [
            TextField(
              controller: name,
              decoration: InputDecoration(
                hintText: "Enter Your Name",
              ),
            ),
            TextField(
              controller: surname,
              decoration: InputDecoration(
                hintText: "Enter Your Surname",
              ),
            ),
            TextField(
              controller: email,
              decoration: InputDecoration(
                hintText: "Enter Your Email",
              ),
            ),
            DropdownButton(
              // Initial Value
              value: selectedCourse,

              // Down Arrow Icon
              icon: const Icon(Icons.keyboard_arrow_down),

              // Array list of items
              items: courses.map((String items) {
                return DropdownMenuItem(
                  value: items,
                  child: Text(items),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  selectedCourse = newValue!;
                });
              },
            ),
            TextField(
              controller: address,
              decoration: InputDecoration(
                hintText: "Enter Your Address",
              ),
            ),
            TextField(
              controller: pincode,
              decoration: InputDecoration(
                hintText: "Enter Your Pincode",
              ),
            ),
            DropdownButton(
              // Initial Value
              value: selectedCity,
              icon: const Icon(Icons.keyboard_arrow_down),
              items: cities.map((String items) {
                return DropdownMenuItem(
                  value: items,
                  child: Text(items),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  selectedCity = newValue!;
                });
              },
            ),
            TextField(
              controller: totalFees,
              decoration: InputDecoration(
                hintText: "Enter Total Fees",
              ),
            ),
            TextField(
              controller: contact,
              decoration: InputDecoration(
                hintText: "Enter Your Contact",
              ),
            ),
            TextField(
              controller: marks,
              decoration: InputDecoration(
                hintText: "Enter Your Marks",
              ),
            ),
            ElevatedButton(
                onPressed: () {
                  print('${name.text.toString()} =='
                      ' ${surname.text.toString()}"'
                      ' ${email.text.toString()}"'
                      ' ${selectedCourse.toString()} == $selectedCity"'
                      ' ${address.text.toString()}"'
                      ' ${totalFees.text.toString()}"'
                      ' ${contact.text.toString()}"'
                      ' ${marks.text.toString()}"'
                      '');

                  mydb.db.rawInsert(
                      "INSERT INTO student_data (FirstName,LastName,Email,Course,Address,Pincode,City,TotalFees,ContactNumber,Marks) values(?,?,?,?,?,?,?,?,?,?)",
                      [
                        name.text.toString(),
                        surname.text.toString(),
                        email.text.toString(),
                        selectedCourse,
                        address.text.toString(),
                        pincode.text.toString(),
                        selectedCity,
                        totalFees.text.toString(),
                        contact.text.toString(),
                        marks.text.toString()
                      ]);
                  print("Inserted");
                  setState(() {
                  });
                },
                child: Text("Insert")),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}