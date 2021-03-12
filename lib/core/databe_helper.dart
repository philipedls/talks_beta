import 'dart:io' as io;

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:talks_beta/models/record.dart';

class DBHelper {
  static Database _db;

  Future<Database> get db async {
    if (_db != null) {
      return _db;
    }
    _db = await initDatabase();
    return _db;
  }

  Future<Database> initDatabase() async {
    io.Directory documentDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentDirectory.path, 'talkz.db');
    var db = await openDatabase(path, version: 1, onCreate: _onCreate);
    return db;
  }

  _onCreate(Database db, int version) async {
    await db.execute(
        'CREATE TABLE record (id INTEGER PRIMARY KEY, title TEXT, content TEXT, date TEXT)');
  }

  Future<Record> add(Record record) async {
    var dbClient = await db;
    record.id = await dbClient.insert('record', record.toMap());
    return record;
  }

  Future<List<Record>> getRecords() async {
    var dbClient = await db;
    List<Map> maps = await dbClient
        .query('record', columns: ['id', 'title', 'content', 'date']);
    List<Record> records = [];
    if (maps.length > 0) {
      for (int i = 0; i < maps.length; i++) {
        records.add(Record.fromMap(maps[i]));
      }
    }
    return records;
  }

  Future<int> delete(int id) async {
    var dbClient = await db;
    return await dbClient.delete(
      'record',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<int> update(Record student) async {
    var dbClient = await db;
    return await dbClient.update(
      'record',
      student.toMap(),
      where: 'id = ?',
      whereArgs: [student.id],
    );
  }

  Future close() async {
    var dbClient = await db;
    dbClient.close();
  }

  Future deleteDB() async {
    io.Directory documentDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentDirectory.path, 'talkz.db');

    deleteDatabase(path);
  }
}
