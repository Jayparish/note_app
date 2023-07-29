import 'dart:io';

import 'package:drift/drift.dart';
import 'package:path_provider/path_provider.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart' as p;

part 'database.g.dart';


class Note extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get title => text()();
  TextColumn get description => text().named('description')();
  IntColumn get priority => integer().nullable()();
  IntColumn get color => integer().nullable()();
}
LazyDatabase _openConnection() {

  return LazyDatabase(() async {

    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'db.sqlite'));
    return NativeDatabase.createInBackground(file);
  });
}


@DriftDatabase(tables: [Note])
class AppDatabase extends _$AppDatabase{
  AppDatabase() : super(_openConnection());


  @override
  int get schemaVersion => 1;
  // get all notes from db
  Future<List<NoteData>> getNoteList()async{
    return await select(note).get();
  }
  //insert new note
  Future<int> insertnote(NoteCompanion noteCompanion)async{
    return await into(note).insert(noteCompanion);
  }
  //delete from db
  Future<int> deletenote(NoteData noteData)async{
    return await delete(note).delete( noteData);

  }
  Future<bool>updatenotes(NoteData noteData)async{
    return await update(note).replace(noteData);

  }

}