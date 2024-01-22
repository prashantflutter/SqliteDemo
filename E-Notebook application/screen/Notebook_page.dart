import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:project1/E-Notebook%20application/screen/home_page.dart';

import '../Database/database.dart';

class NotebookPage extends StatefulWidget {
  final bool isDesc;
  final String? noteLogo;
  final String? title;
  final String? description;
  const NotebookPage({super.key, this.isDesc = false, this.noteLogo, this.title, this.description});

  @override
  State<NotebookPage> createState() => _NotebookPageState();
}

class _NotebookPageState extends State<NotebookPage> {



  TextEditingController titleController = TextEditingController();
  TextEditingController descController = TextEditingController();
  ImagePicker picker = ImagePicker();
  XFile? image;
  List<Widget>addWidgetsList = [];
  List<Map<String,dynamic>> addNotebookDataList = [];
  Future<void>addData()async{
    await SQLiteDatabase.createData(titleController.text.toString(), descController.text.toString(),image!.path);
    _refreshData();
  }

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
        backgroundColor: Colors.black,
        automaticallyImplyLeading: false,
        title: widget.isDesc == true?Text(widget.title!,style: TextStyle(color: Colors.white),): Text('E-Notebook Write',style: TextStyle(color: Colors.white),),
        actions: [
        ],
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            SizedBox(height: 15,),
            widget.isDesc == true?ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.file(File(widget.noteLogo!),width: size.width, height:size.height*0.3 ,fit: BoxFit.contain,),):
            Row(
              children: [
                InkWell(
                  onTap: ()async{
                    image = await picker.pickImage(source: ImageSource.gallery);
                    setState(() {});
                  },
                  child: Container(
                    width: 60,height: 60,
                    decoration: BoxDecoration(
                      color:  image != null?null:Colors.grey,
                      borderRadius: BorderRadius.circular(16),
                      image: image != null?DecorationImage(image: FileImage(File(image!.path)),fit: BoxFit.contain):null,
                    ),
                    child: image == null?Icon(Icons.add,color: Colors.white,):Container(),
                  ),
                ),
                SizedBox(width: 10,),
                Expanded(
                  child: TextFormField(
                    controller: titleController,
                    decoration: InputDecoration(
                      hintText: 'Write Title of Notebook',
                      border: InputBorder.none,
                    ),
                  ),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5)
                    )
                  ),
                    onPressed: (){
                    if(titleController.text.isEmpty || image == null || descController.text.isEmpty){
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Row(
                          children: [
                            Icon(Icons.error_outline,color: Colors.white,size: 25,),
                            SizedBox(width: 5,),
                            Expanded(child: Text('Please Create NoteBook to add Book Logo ,Title and Write content of Book!',maxLines: 2,)),
                          ],
                        ),
                        backgroundColor: Colors.redAccent,
                        padding: EdgeInsets.symmetric(horizontal: 10,vertical: 15),)
                      );
                    }else{
                      addData();
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>HomePage()));
                      setState(() {});
                      ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Row(
                            children: [
                              Icon(Icons.download_done_outlined,color: Colors.white,size: 25,),
                              SizedBox(width: 5,),
                              Expanded(child: Text('Successfully added NoteBook...',maxLines: 2,)),
                            ],
                          ),
                            backgroundColor: Colors.green, padding: EdgeInsets.symmetric(horizontal: 10,vertical: 15),)
                      );
                    }

                }, child:Text('Add \nNoteBook',textAlign: TextAlign.center,style: TextStyle(color: Colors.white,fontSize: 12),) )
              ],
            ),
            widget.isDesc == true?SizedBox(height: 25,):SizedBox(),
            widget.isDesc?Expanded(
              child: SingleChildScrollView(
                child: TextFormField(
                  controller: descController,
                  minLines: 1,
                  maxLines: 500,
                  readOnly: true,
                  decoration: InputDecoration(
                    hintText: widget.description,
                    border: InputBorder.none,
                  ),
                ),
              ),
            ):
            Expanded(
              child: TextFormField(
                controller: descController,
                minLines: 1,
                maxLines: 500,
                decoration: InputDecoration(
                  hintText: 'Write book content...',
                  border: InputBorder.none,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
