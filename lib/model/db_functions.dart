import 'package:sqflite/sqflite.dart';
import 'package:text_collector/model/app_model.dart';

late Database db;
Future<void> initDataBases() async {
  db = await openDatabase(
    'texts.db',
    version: 1,
    onCreate: (db, version) async {
      await db.execute(
          'CREATE TABLE text_table (id INTEGER PRIMARY KEY, title TEXT, imagePath TEXT)');
    },
  );
}

Future<List<AppModel>> getAllData() async {
  final List<Map<String, dynamic>> result =
      await db.rawQuery('SELECT * FROM text_table');
  final data = result.map((map) => AppModel.fromMap(map)).toList();

  return data;
}

Future<void> addData(AppModel textData) async {
  await db.rawInsert(
      'INSERT INTO text_table(title,imagePath)VALUES("${textData.title}","${textData.imagePath}")');
}

Future<void> updateData() async {}
Future<void> deleteData() async {}
