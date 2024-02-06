import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
// import 'package:sqflitedb/main.dart';

import 'db.dart';

class AddFaculty extends StatefulWidget {
  const AddFaculty({Key? key}) : super(key: key);

  @override
  State<AddFaculty> createState() => AddFacultyState();
}
class AddFacultyState extends State<AddFaculty> {
  TextEditingController name = TextEditingController();
  TextEditingController surname = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController experience = TextEditingController();


  late Mydb mydb = Mydb();

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
            TextField(
              controller: experience,
              decoration: InputDecoration(
                hintText: "Enter Your experience",
              ),
            ),

            ElevatedButton(
                onPressed: () {
                  mydb.db.rawInsert(
                      "INSERT INTO student_data (name,surname,email,experience) values(?,?,?,?)",
                      [
                        name.text.toString(),
                        surname.text.toString(),
                        email.text.toString(),
                        experience.text.toString(),
                      ]);
                  print("Inserted");
                },
                child: Text("Insert")),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
