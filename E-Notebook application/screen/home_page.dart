import 'dart:io';
import 'package:flutter/material.dart';
import '../Database/database.dart';
import 'Notebook_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  List<Map<String,dynamic>> addNotebookDataList = [];
  List<Map<String, dynamic>> searchResultsList = [];
  TextEditingController searchController = TextEditingController();
  bool isSearch = false;

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
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.black,
        leading:isSearch?IconButton(onPressed: (){
          setState(() {
            isSearch = false;
            searchController.clear();
          });
        }, icon: Icon(Icons.arrow_back_ios_rounded,color: Colors.white)):null,
        title: isSearch?null:Text('E-Notebook',style: TextStyle(color: Colors.white),),
        actions: [
          isSearch?SizedBox(
            width: size.width*0.74,
            child: TextFormField(
              controller: searchController,
              cursorColor: Colors.white,
              style: TextStyle(color: Colors.white,),
              decoration: InputDecoration(
                hintText: 'Search book...',
                hintStyle: TextStyle(color: Colors.grey,),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                ),
              ),
              onChanged: (value)async{
                List<Map<String,dynamic>>searchResult = await SQLiteDatabase.searchDataByTitle(value);
                setState(() {
                  searchResultsList = searchResult;
                });
              },
            ),
          ):SizedBox(),
          isSearch?SizedBox():IconButton(onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context)=> NotebookPage()));
          }, icon: Icon(Icons.add,color: Colors.white)),
          isSearch?IconButton(onPressed: (){
            setState(() {
              searchController.clear();
            });
          }, icon: Icon(Icons.clear,color: Colors.white)):IconButton(onPressed: (){
            setState(() {
              isSearch = true;
            });
          }, icon: Icon(Icons.search,color: Colors.white)),
          SizedBox(width: 10,)
        ],
      ),
      body: Container(
        child:addNotebookDataList.isEmpty?Center(child: Text('Empty Data!',style: TextStyle(color: Colors.black,fontSize: 25,fontWeight: FontWeight.w900),)):GridView.count(
            crossAxisCount: 2,
            children: searchController.text.length>0?List.generate(searchResultsList.length, (index){
              return InkWell(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=> NotebookPage(isDesc: true,noteLogo: searchResultsList[index]['bookLogo'],title:searchResultsList[index]['title'],description: searchResultsList[index]['desc'],)));
                },
                child: Column(
                  children: [
                    SizedBox(height: 5,),
                    Image.file(File(searchResultsList[index]['bookLogo']),width: 100,height: 150,fit: BoxFit.cover,),
                    SizedBox(height: 5,),
                    Text(searchResultsList[index]['title'],textAlign: TextAlign.center,maxLines: 3,style: TextStyle(color: Colors.black,fontSize: 12,fontWeight: FontWeight.w900),)
                  ],
                ),
              );
            }):
            List.generate(addNotebookDataList.length, (index){
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
