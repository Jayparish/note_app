import 'package:drift/drift.dart' as dr;
import 'package:flutter/material.dart';
import 'package:note_app/Database/database.dart';
import 'package:provider/provider.dart';

class Notedetail extends StatefulWidget {
  final String title;
  final NoteCompanion noteCompanion;
  const Notedetail({Key? key, required this.title, required this.noteCompanion}) : super(key: key);

  @override
  State<Notedetail> createState() => _NotedetailState();
}

class _NotedetailState extends State<Notedetail> {
  late AppDatabase appdatabase;
  TextEditingController titlecontroller= TextEditingController();
  TextEditingController desccontroller= TextEditingController();

  @override
  void initState() {
    titlecontroller.text=widget.noteCompanion.title.value;
    desccontroller.text=widget.noteCompanion.description.value;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    appdatabase = Provider.of<AppDatabase>(context);
    return Scaffold(
      appBar:_getdetailappbar(),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 20),
          child: Column(
            children: [
              TextFormField(
                controller: titlecontroller,
                decoration: InputDecoration(
                  labelText: 'Enter title',
                  border: OutlineInputBorder(

                    borderRadius: BorderRadius.circular(20)
                  ),

                ),
              ),
              SizedBox(height: 30,),
              TextFormField(
                controller: desccontroller,


                maxLines: 8,
                minLines: 7,
                maxLength: 255,
                decoration: InputDecoration(
                  hintText: 'Enter title',
                  border: OutlineInputBorder(

                    borderRadius: BorderRadius.circular(20)
                  ),

                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  _getdetailappbar() {
    return AppBar(
      backgroundColor: Colors.blue,
      title: Text(widget.title, ),
      actions: [
        IconButton(onPressed: (){
          _savetodb();

        }, icon: Icon(Icons.save)),
        IconButton(onPressed: (){

          _deletenotes();
        }, icon: Icon(Icons.delete)),
      ],
    );
  }

  void _savetodb() {
    if(widget.noteCompanion.id.present){
      
      appdatabase.updatenotes(NoteData(
          id: widget.noteCompanion.id.value,
           color: 1,
           priority: 1,
          title: titlecontroller.text,
          description:desccontroller.text)).then((value) {
        Navigator.pop(context,true);
      });


    }else{
      appdatabase.insertnote(
          NoteCompanion(
            title: dr.Value(titlecontroller.text),
            description: dr.Value(desccontroller.text),
            color: dr.Value(1),
            priority: dr.Value(1),
          )
      ).then((value) {
        Navigator.pop(context,true);
      });
    }

  }

  void _deletenotes() {
    showDialog(context: context, builder: (context)=> AlertDialog(
      title: Text('Delete notes ?'),
      content: Text('Do yoy want to delete'),
      actions: [

        ElevatedButton(onPressed:(){
          Navigator.pop(context);

        }, child: Text('Cancel')),
        ElevatedButton(onPressed:(){
          Navigator.pop(context);
          appdatabase.deletenote(NoteData(
              id:widget.noteCompanion.id.value,
              title: widget.noteCompanion.title.value,
              description: widget.noteCompanion.description.value


          )).then((value){
            Navigator.pop(context,true);
          });
        }, child: Text('Delete')),
      ],
    ));

  }




}
