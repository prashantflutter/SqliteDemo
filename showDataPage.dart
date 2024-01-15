import 'package:flutter/material.dart';
import 'package:untitled/tasks/database.dart';


class ShowDataPage extends StatefulWidget {
  const ShowDataPage({super.key});

  @override
  State<ShowDataPage> createState() => _ShowDataPageState();
}

class _ShowDataPageState extends State<ShowDataPage> {
  // Created List for fetch all Data and set in List Object to
  // use data where we want
  List<Map<String,dynamic>> allData = [];

  bool isLoading = true;
  TextEditingController titleController = TextEditingController();
  TextEditingController descController = TextEditingController();


  // created Method to refresh Data first when page load
  void _refreshData() async {
    final data = await SQLiteDatabase.getAllData();
    setState(() {
      allData = data;
      isLoading = false;
    });
  }


  // Create Method for add Data to database
  Future<void>addData()async{
    await SQLiteDatabase.createData(titleController.text.toString(), descController.text.toString());
    _refreshData();
  }

  // Create Method for updateData in database
  Future<void>updateData(int id)async{
    await SQLiteDatabase.updateData(id, titleController.text.toString(), descController.text.toString());
    reassemble();
  }

  // Create Method for Delete Data  in database
  Future<void>deleteData(int id)async{
    await SQLiteDatabase.deleteData(id);
    reassemble();
  }


  @override
  void initState() {
    super.initState();
    _refreshData();
  }

  void showBottomSheet(int? id)async{
    if(id!= null){
      final exitingData = allData.firstWhere((element) => element['id']==id);
      titleController.text = exitingData['title'];
      descController.text = exitingData['desc'];
    }
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (_){
          return Container(
            padding: EdgeInsets.only(top: 15,left: 15,right: 15,
                bottom: MediaQuery.of(context).viewInsets.bottom),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                SizedBox(height: 10,),
                TextFormField(
                  controller: titleController,
                  decoration: InputDecoration(
                    labelText: 'Enter Title',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 10,),
                TextFormField(
                  controller: descController,
                  maxLines: 4,
                  decoration: InputDecoration(
                    labelText: 'Enter Description',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 10,),
                Center(
                  child: ElevatedButton(
                    onPressed: ()async{
                      print('addData Id ===> $id');
                    if(id == null){
                      await addData();
                      setState(() {});
                    }
                    if(id != null){
                      print('updateData Id ===> $id');
                      await updateData(id);
                      setState(() {});
                    }
                    titleController.clear();
                    descController.clear();
                    Navigator.of(context).pop();
                  },child:Text(id == null? "Add Data" : "Update Data"),),
                ),
                SizedBox(height: 10,),
              ],
            ),
          );
    });
  }


  @override
  Widget build(BuildContext context){
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(title: Text("Sqlite DataBase CRDU"),),
      body: ListView.builder(
        itemCount: allData.length,
          itemBuilder: (context,index) => Card(
            margin: EdgeInsets.all(15),
            child: Container(
              width: double.infinity,
              child: ListTile(
                title: Column(
                  children: [
                    SizedBox(height: 10,),
                    Text(allData[index]['title'],style: TextStyle(color: Colors.black,fontSize: 20),),
                    Text(allData[index]['desc'],style: TextStyle(color: Colors.black,fontSize: 16),)
                  ],
                ),
                subtitle:Row(
                  children: [
                    IconButton(
                      onPressed: (){
                        showBottomSheet(allData[index]['id']);
                      },
                      icon: Icon(Icons.edit),),
                    IconButton(
                      onPressed: (){
                        deleteData(allData[index]['id']);
                      }, icon: Icon(Icons.delete),),
                  ],
                ),
              ),
            ),
          ),
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () => showBottomSheet(null),
        child: Icon(Icons.add),
      ),
    );
  }
}
