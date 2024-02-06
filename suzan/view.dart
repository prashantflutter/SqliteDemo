import 'package:flutter/material.dart';
import 'db.dart';
import 'edit.dart';
import 'myapp.dart';

class ViewData extends StatefulWidget
{
  const ViewData({super.key});
  @override
  State<ViewData> createState() => _ViewDataState();
}
class _ViewDataState extends State<ViewData> {
  late Mydb db = Mydb();
  List<Map> slist = [];

  @override
  void initState()
  {
    super.initState();
    db.open();
    getdata();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("View Details"),),
        body:  Container(child: slist.length == 0 ? Text("No any students to show.") :
        Column(
          children: slist.map((stuone){
            return Card(
              child: ListTile(
                leading: Icon(Icons.people),
                title: Text(stuone["FirstName"].toString()),
                subtitle: Text("Email:" + stuone["Email"].toString() + ", Surname: " + stuone["LastName"]),
                trailing: Wrap(
                    children: [
                      IconButton(
                        onPressed: () {
                          var id = stuone["ID"];
                          debugPrint('id == $id');
                          Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => EditStudent(id: id)));
                        },
                        icon: Icon(Icons.edit),),
                      IconButton(onPressed: () {
                        db.db.rawDelete("DELETE FROM student_data where ID = ?",[stuone["ID"]]);
                        print("Data Deleted");
                        Navigator.pushReplacement(context,MaterialPageRoute(builder: (context) => MyApp()));
                      }, icon: Icon(Icons.delete),),
                    ]
                ),
              ),
            );
          }).toList(),
        )
        )
    );
  }
  void getdata() {
    Future.delayed(Duration(milliseconds: 500),() async
    {
      slist = await db.db.rawQuery('SELECT * FROM student_data');
      print('slist == $slist');
      setState(() {});
    });
  }
}
