 import 'package:flutter/material.dart';
// import 'package:sqflitedb/db.dart';
// import 'package:sqflitedb/main.dart';
import 'package:sqflite/sqflite.dart';

import 'db.dart';


class ViewFaculty extends StatefulWidget
{
  const ViewFaculty({super.key});

  @override
  State<ViewFaculty> createState() => ViewFacultyState();

}

class ViewFacultyState extends State<ViewFaculty> {

  late Mydb db = Mydb();
  List<Map> flist = [];

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
        body:  SingleChildScrollView
          (

            child: Container
              (

                child: flist.length == 0 ?
                Text("No any faculty to show.")
                    :
                Column(

                    children: flist.map((facone)
                    {
                      return Card
                        (
                        child: ListTile(
                          leading: Icon(Icons.people),
                          title: Text(facone["name"]),
                          subtitle: Text("Email:" + facone["email"].toString() + ", Surname: " + facone["surname"]),
                        ),
                      );
                    })
                        .toList())
            )
        )
    );
  }
  void getdata()
  {
    Future.delayed(Duration(milliseconds: 500),() async
    {
      flist = await db.db.rawQuery('SELECT * FROM faculty');
      setState(() {
      });
    });


  }


}
