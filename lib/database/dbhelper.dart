import 'package:sqflite/sqflite.dart';

class DBHelper {
  static Database? _db;
  
  static const String QUERY_TBL_ITINERARY = """
    CREATE TABLE aktivitas (
      id INTEGER PRIMARY KEY,
      onDate TEXT,
      activity_name TEXT,
      activity_time TEXT, 
    )
  """;

  static Future<Database?> db() async {
    return _db ??=(await DBHelper().connectDB());
  }

  //Method untuk koneksi ke file Database SQLite
  Future<Database> connectDB() async {
    return await openDatabase('mydatabase.db', version: 1, onCreate: (db, version) {
      db.execute(QUERY_TBL_ITINERARY);
    });
  }
}