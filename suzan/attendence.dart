import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class Student {
  String name;
  bool isPresent;
  Student({required this.name, this.isPresent = false});
}
class AttendencePage extends StatelessWidget {
  final List<Student> students = [
    Student(name: 'Student 1'),
    Student(name: 'Student 2'),
    Student(name: 'Student 3'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Student Attendance'),
      ),
      body: AttendanceList(students: students),
    );
  }
}

class AttendanceList extends StatefulWidget {
  final List<Student> students;

  AttendanceList({required this.students});

  @override
  AttendanceListState createState() => AttendanceListState();
}

class AttendanceListState extends State<AttendanceList> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: widget.students.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(widget.students[index].name),
          trailing: Checkbox(
            value: widget.students[index].isPresent,
            onChanged: (value) {
              setState(() {
                widget.students[index].isPresent = value ?? false;
              });
            },
          ),
        );
      },
    );
  }
}
