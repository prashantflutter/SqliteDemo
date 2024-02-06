import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'add.dart';
import 'addfaculty.dart';
import 'attendence.dart';
import 'view.dart';
import 'viewfaculty.dart';


class MyApp extends StatelessWidget
{
  @override
  Widget build(BuildContext context)
  {
    return Scaffold(
      appBar: AppBar(title: Text("Android Attendence System", style: TextStyle(color: Colors.white),),
        backgroundColor: Colors.black,
        leading: Image.network(
          "https://i.insider.com/525ac397ecad044e0bc07620?width=750&format=jpeg&auto=webp",
          width: 50,
          height: 50,
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.more_vert_sharp),
            onPressed: () {},
          ),
        ],
      ),
      body: Container
        (
        decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage("https://media.istockphoto.com/id/1387666645/vector/abstract-soft-varicoloured-background-vector-illustration-for-different-screen-designs.jpg?s=612x612&w=0&k=20&c=11RLWjE6VK-pFsOeJNWN2wB_5lX8XxgykqsChyb6vDY="),
            fit: BoxFit.cover,
          ),
        ),
        alignment: Alignment.topCenter,
        padding: EdgeInsets.all(20),
        child: Column(
          children:
          [
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => AddData(email: null,)));
                },
                child: Text("Add Student", style: TextStyle(fontSize: 20),),
              ),
            ),
            SizedBox(height: 20),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => ViewData()));
                },
                child: Text("View Student", style: TextStyle(fontSize: 20)),
              ),
            ),
            SizedBox(height: 20),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => AttendencePage()));
                },
                child: Text("Attendance of Student", style: TextStyle(fontSize: 20)),
              ),
            ),
            SizedBox(height: 150),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => AddFaculty()));
                },
                child: Text("Add Faculty", style: TextStyle(fontSize: 20)),
              ),
            ),
            SizedBox(height: 20),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => ViewFaculty()));
                },
                child: Text("View Faculty", style: TextStyle(fontSize: 20)),
              ),
            ),
            SizedBox(height: 20),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  SystemNavigator.pop();
                },
                child: Text("Logout", style: TextStyle(fontSize: 20),),
              ),
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}