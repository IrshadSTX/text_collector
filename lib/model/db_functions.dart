import 'package:sqflite/sqflite.dart';
import 'package:text_collector/model/app_model.dart';

late Database db;
Future<void> initDataBases() async {
  db = await openDatabase(
    'texts.db',
    version: 1,
    onCreate: (db, version) async {
      await db.execute(
          'CREATE TABLE text_table (id INTEGER PRIMARY KEY, title TEXT, imagePath TEXT,date TEXT)');
    },
  );
}

Future<void> addData(AppModel textData) async {
  await db.rawInsert(
      'INSERT INTO text_table(title,imagePath,date) VALUES("${textData.title}","${textData.imagePath}","${textData.date!.toIso8601String()}")');
}

Future<void> updateData(String newTitle, int id) async {
  await db.rawUpdate(
    'UPDATE text_table SET title = ? WHERE id = ?',
    [newTitle, id],
  );
  print('updated: $newTitle');
}
