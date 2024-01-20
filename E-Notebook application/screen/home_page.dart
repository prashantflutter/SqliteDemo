import 'dart:io';

import 'package:flutter/material.dart';

import '../Database/database.dart';
import 'EditorNotes.dart';
import 'Notebook_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  List<Map<String,dynamic>> addNotebookDataList = [];

  void _refreshData() async {
    final data = await SQLiteDatabase.getAllData();
    setState(() {
      addNotebookDataList = data;
    });
  }

  @override
  void initState() {
    _refreshData();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text('E-Notebook',style: TextStyle(color: Colors.white),),
        actions: [
          IconButton(onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context)=> EditorNotesPage()));
          }, icon: Icon(Icons.add,color: Colors.white)),
          IconButton(onPressed: (){}, icon: Icon(Icons.search,color: Colors.white)),
          SizedBox(width: 10,)
        ],
      ),
      body: Container(
        child:addNotebookDataList.isEmpty?Center(child: Text('Empty Data!',style: TextStyle(color: Colors.black,fontSize: 25,fontWeight: FontWeight.w900),)):GridView.count(
            crossAxisCount: 2,
            children: List.generate(addNotebookDataList.length, (index){
            return InkWell(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=> NotebookPage(isDesc: true,noteLogo: addNotebookDataList[index]['bookLogo'],title:addNotebookDataList[index]['title'],description: addNotebookDataList[index]['desc'],)));
              },
              child: Column(
                children: [
                  SizedBox(height: 5,),
                  Image.file(File(addNotebookDataList[index]['bookLogo']),width: 100,height: 150,fit: BoxFit.cover,),
                  SizedBox(height: 5,),
                  Text(addNotebookDataList[index]['title'],textAlign: TextAlign.center,maxLines: 3,style: TextStyle(color: Colors.black,fontSize: 12,fontWeight: FontWeight.w900),)
                ],
              ),
            );
          }),
        ),
      ),
    );
  }
}
