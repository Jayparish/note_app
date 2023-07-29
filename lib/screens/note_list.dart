
import 'package:drift/drift.dart' as dr;
import 'package:flutter/material.dart';

import 'package:note_app/Database/database.dart';
import 'package:note_app/screens/common_hover_card.dart';
import 'package:note_app/screens/note_detail.dart';
import 'package:provider/provider.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_grid_view.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_tile.dart';

class Notelist extends StatefulWidget {
  const Notelist({Key? key}) : super(key: key);

  @override
  State<Notelist> createState() => _NotelistState();
}

class _NotelistState extends State<Notelist> {
  late AppDatabase database;
  @override
  Widget build(BuildContext context) {
    database= Provider.of<AppDatabase>(context);
    return  Scaffold(
     body: FutureBuilder<List<NoteData>>(
       future: _getnotefromdatabase(),
       builder: (context, snapshot) {
         if(snapshot.hasData){
           List<NoteData>? noteList=snapshot.data;

           if(noteList!=null ){
             if(noteList.isEmpty){
               return Center(child: Text('No notes found',
                 style:Theme.of(context).textTheme.bodyText2,
                 textAlign: TextAlign.center

                 ,),);
             }else{
               return notelistUI(noteList);
             }


           }

         }
         else if(snapshot.hasError){
           return Center(child: Text(snapshot.hasError.toString(),style:Theme.of(context).textTheme.bodyText2),);
         }
         return Center(child: Text('Click on add button to add new note',
           style:Theme.of(context).textTheme.bodyText2

           ,),);
       },
     ),
      floatingActionButton: FloatingActionButton(
        shape: const CircleBorder(), onPressed: () {
          _navigatetodetail('Add Note ', const NoteCompanion(
            title: dr.Value(''),
            description: dr.Value(''),
              color: dr.Value(1),
            priority: dr.Value(1)

          ));

        },
        child: Icon(Icons.add),

      ),
    );
  }

  Future<List<NoteData>>_getnotefromdatabase() async{
    return await database.getNoteList();
  }

  Widget notelistUI(List<NoteData> noteList) {
    return StaggeredGridView.countBuilder(
      itemCount: noteList.length,
        crossAxisCount: 4,
        itemBuilder: (context, index) {
        NoteData noteData =noteList[index];
          return InkWell(
            borderRadius: BorderRadius.circular(20),
            splashColor: Colors.transparent,
            focusColor: Colors.transparent,
            highlightColor: Colors.transparent,
            hoverColor: Colors.transparent,


            onTap: (){
              _navigatetodetail('Edit note',
                  NoteCompanion(
                    id: dr.Value(noteData.id),
                    title: dr.Value(noteData.title),
                    description: dr.Value(noteData.description),
                    color: dr.Value(noteData.color),
                    priority: dr.Value(noteData.priority),

                  ));
            },
            child: Container(

              margin:  EdgeInsets.symmetric(vertical: 10,horizontal: 10),
              //padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),

              ),
              child: Commonhovercard(
                child: Card(

                  elevation: 10,

                  shape:RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(noteData.title),
                           Text( _getpriority(noteData.priority??1))
                          ],
                        ),
                        Text(noteData.description),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [Text('12/12/2023',style: Theme.of(context).textTheme.subtitle2,)],)
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
        staggeredTileBuilder: (index)=>StaggeredTile.fit(2)
    );

  }

 _navigatetodetail(String title, NoteCompanion noteCompanion) async {
    var res = await Navigator.push(context,MaterialPageRoute(builder: (context)=>Notedetail(
      title: title,
      noteCompanion: noteCompanion)));
    if(res != null && res==true){
      setState(() {

      });

    }
  }

  String _getpriority(int p) {
    switch(p){
      case 1:
        return'!!!';
      case 2:
        return'!!';
      default:
        return'!';
    }

  }


}

