import 'package:flutter/material.dart';
import '../main.dart';
import 'db.dart';
import 'myapp.dart';

class EditStudent extends StatefulWidget
{
  int id;
  EditStudent({required this.id});
  @override
  State<EditStudent> createState() => _State();
}
class _State extends State<EditStudent>
{
  TextEditingController id = TextEditingController();
  TextEditingController name = TextEditingController();
  TextEditingController surname = TextEditingController();
  late Mydb mydb = Mydb();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    mydb.open();

    Future.delayed(Duration(microseconds: 500),()async {
      String id2 = '${widget.id}';
      var data = await mydb.getsinglerecord(id2);
      if(data != null) {
        id.text = data["ID"];
        name.text = data["FirstName"];
        surname.text = data["LastName"];
        setState(() {
        });
      }
      else
      {
        print("No any data with id " + widget.id.toString());
      }
    });
  }
  @override
  Widget build(BuildContext context)
  {
    return Scaffold(appBar: AppBar(title: Text("Edit Page"),),
      body:
      Container
        (
        padding: EdgeInsets.all(30),
        child: Column(

          children: [
            TextField(
              controller: id,
              decoration: InputDecoration(
                hintText: "Enter Your id",
              ),
            ),
            TextField(
              controller: name,
              decoration: InputDecoration(
                hintText: "Enter Your Name",
              ),
            ),

            TextField(
              controller: surname,
              decoration: InputDecoration
                (
                hintText: "Enter Your Surname",
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(onPressed: ()
              {
                mydb.db.rawUpdate("update student_data set name=?,surname=? where id=?",[name.text.toString(),surname.text.toString(),id.text.toString()]);
                print("Updated");
                Navigator.pushReplacement(context,MaterialPageRoute(builder: (context) => MyApp()));
              }, child: Text("Update")),
            )
          ],
        ),
      ),
    );
  }
}