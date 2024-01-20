import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:flutter_quill_extensions/embeds/image/toolbar/image_button.dart';
import 'package:flutter_quill_extensions/embeds/others/camera_button/camera_button.dart';
import 'package:flutter_quill_extensions/embeds/video/toolbar/video_button.dart';
import 'package:flutter_quill_extensions/models/config/shared_configurations.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pdf/pdf.dart';
import 'package:printing/printing.dart';
import 'package:project1/E-Notebook%20application/screen/MyQuillEditor.dart';
import 'package:project1/E-Notebook%20application/screen/home_page.dart';
import 'package:quill_pdf_converter/quill_pdf_converter.dart';
import '../Database/database.dart';
import 'package:pdf/widgets.dart' as pw;

class EditorNotesPage extends StatefulWidget {

   EditorNotesPage({super.key,});

  @override
  State<EditorNotesPage> createState() => _EditorNotesPageState();
}

class _EditorNotesPageState extends State<EditorNotesPage> {

  final controller = QuillController.basic();
  final ScrollController scrollController = ScrollController();
  final FocusNode focusNode = FocusNode();
  var _isReadOnly = false;
  TextEditingController titleController = TextEditingController();
  ImagePicker picker = ImagePicker();
  XFile? image;

  List<Map<String,dynamic>> addNotebookDataList = [];
  Future<void>addData()async{
    await SQLiteDatabase.createData(titleController.text.toString(), controller.toString(),image!.path);
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
    return Scaffold(
      appBar: AppBar(
        title: Text('Note Editor'),
        actions: [
          IconButton(onPressed: ()async{
            if(titleController.text.isEmpty ){
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('create noteBook?'),backgroundColor: Colors.redAccent,)
              );
            }else{
              final pdfDocument = pw.Document();
              final pdfWidgets = await controller.document.toDelta().toPdf();
              pdfDocument.addPage(
                pw.MultiPage(
                  maxPages: 200,
                  pageFormat: PdfPageFormat.a4,
                  build: (context) {
                    return pdfWidgets;
                  },
                ),
              );
              await Printing.layoutPdf(onLayout: (format) async => pdfDocument.save());
              addData();
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> HomePage()));
              setState(() {});
            }
            }, icon: Icon(Icons.save,)),
          SizedBox(width: 5,),
        ],
      ),
      body: Column(
        children: [
          if (!_isReadOnly)QuillToolbar(child: SingleChildScrollView(
             scrollDirection: Axis.horizontal,
             child: Wrap(
               children: [
                 // IconButton(
                 //   onPressed: () => context.read<SettingsCubit>().updateSettings(state.copyWith(useCustomQuillToolbar: false)),
                 //   icon: const Icon(
                 //     Icons.width_normal,
                 //   ),
                 // ),
                 QuillToolbarHistoryButton(
                   isUndo: true,
                   controller: controller,
                 ),
                 QuillToolbarHistoryButton(
                   isUndo: false,
                   controller: controller,
                 ),
                 QuillToolbarToggleStyleButton(
                   options: const QuillToolbarToggleStyleButtonOptions(),
                   controller: controller,
                   attribute: Attribute.bold,
                 ),
                 QuillToolbarToggleStyleButton(
                   options: const QuillToolbarToggleStyleButtonOptions(),
                   controller: controller,
                   attribute: Attribute.italic,
                 ),
                 QuillToolbarToggleStyleButton(
                   controller: controller,
                   attribute: Attribute.underline,
                 ),
                 QuillToolbarClearFormatButton(
                   controller: controller,
                 ),
                 const VerticalDivider(),
                 QuillToolbarImageButton(
                   controller: controller,
                 ),
                 QuillToolbarCameraButton(
                   controller: controller,
                 ),
                 QuillToolbarVideoButton(
                   controller: controller,
                 ),
                 const VerticalDivider(),

               ],
             ),
           )),
          if (!_isReadOnly)QuillToolbar(child: SingleChildScrollView(
             scrollDirection: Axis.horizontal,
             child: Wrap(
               children: [
                 QuillToolbarColorButton(
                   controller: controller,
                   isBackground: false,
                 ),
                 QuillToolbarColorButton(
                   controller: controller,
                   isBackground: true,
                 ),
                 const VerticalDivider(),
                 QuillToolbarSelectHeaderStyleDropdownButton(
                   controller: controller,
                 ),
                 const VerticalDivider(),
                 QuillToolbarToggleCheckListButton(
                   controller: controller,
                 ),
                 QuillToolbarToggleStyleButton(
                   controller: controller,
                   attribute: Attribute.ol,
                 ),
                 QuillToolbarToggleStyleButton(
                   controller: controller,
                   attribute: Attribute.ul,
                 ),
                 QuillToolbarToggleStyleButton(
                   controller: controller,
                   attribute: Attribute.inlineCode,
                 ),
                 QuillToolbarToggleStyleButton(
                   controller: controller,
                   attribute: Attribute.blockQuote,
                 ),
                 QuillToolbarIndentButton(
                   controller: controller,
                   isIncrease: true,
                 ),
                 QuillToolbarIndentButton(
                   controller: controller,
                   isIncrease: false,
                 ),
                 const VerticalDivider(),
                 QuillToolbarLinkStyleButton(controller: controller),
               ],
             ),
           )),
          SizedBox(height: 10,),
          Row(
            children: [
              SizedBox(width: 10,),
              InkWell(
                onTap: ()async{
                  image = await picker.pickImage(source: ImageSource.gallery);
                  setState(() {});
                },
                child: Container(
                  width: 50,height: 50,
                  decoration: BoxDecoration(
                    color: image != null?null:Colors.grey,
                    borderRadius: BorderRadius.circular(12),
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
            ],
          ),
          SizedBox(height: 10,),
          Builder(
            builder: (context) {
              return Expanded(
                child: MyQuillEditor(
                    configurations: QuillEditorConfigurations(
                      sharedConfigurations: _sharedConfigurations,
                      controller: controller,
                      readOnly: _isReadOnly,
                    ),
                    scrollController: scrollController,
                    focusNode: focusNode
                ),
              );
            },
          ),


        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(_isReadOnly ? Icons.lock : Icons.edit),
        onPressed: () => setState(() => _isReadOnly = !_isReadOnly),
      ),
    );
  }
  QuillSharedConfigurations get _sharedConfigurations {
    return const QuillSharedConfigurations(
      // locale: Locale('en'),
      extraConfigurations: {
        QuillSharedExtensionsConfigurations.key:
        QuillSharedExtensionsConfigurations(
          assetsPrefix: 'assets', // Defaults to assets
        ),
      },
    );
  }
}
