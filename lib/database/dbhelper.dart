import 'package:sqflite/sqflite.dart';

class DBHelper {
  static Database? _db;
  
  static const String QUERY_TBL_ACTIVITY = """
    CREATE TABLE activity (
      id INTEGER PRIMARY KEY,
      activity_name TEXT,
      activity_time TEXT, 
      id_day INTEGER,
    ),
  """;

  static const String QUERY_TBL_DAY = """
    CREATE TABLE day (
      id INTEGER PRIMARY KEY,
      onDate TEXT,
    ),
  """;

  static Future<Database?> db() async {
    return _db ??=(await DBHelper().connectDB());
  }

  //Method untuk koneksi ke file Database SQLite
  Future<Database> connectDB() async {
    return await openDatabase('mydatabase.db', version: 1, onCreate: (db, version) {
      db.execute(QUERY_TBL_ACTIVITY);
      db.execute(QUERY_TBL_DAY);
    });
  }
}