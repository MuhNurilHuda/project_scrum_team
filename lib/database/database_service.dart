
import 'package:iterasi1/model/activity.dart';
import 'package:iterasi1/model/day.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../model/itinerary.dart';

class DatabaseService{
  static const _dbName = 'itinerary_db';
  static const _itinerariesTableName = "itineraries";
  static const _activitiesTableName = "activities";
  static const _daysTableName = "days";

  static Future<Database> initializeDB() async {
    return openDatabase(
      join(await getDatabasesPath() , _dbName),
      onCreate: (database, version) async {
        await database.execute(
            "CREATE TABLE $_itinerariesTableName("
                "id STRING PRIMARY KEY,"
                "title STRING"
            ")"
        );

        await database.execute(
          "CREATE TABLE $_daysTableName("
              "id STRING PRIMARY KEY,"
              "id_itinerary STRING,"
              "date STRING"
          ")"
        );

        await database.execute(
          "CREATE TABLE $_activitiesTableName("
              "id STRING PRIMARY KEY,"
              "id_day STRING,"
              "time STRING,"
              "name STRING"
          ")"
        );
      },
      version: 1,
    );
  }

  late Batch batch;

  Future<List<Object?>> executeNewBatch(
      List<void Function()> operations ,
      {bool noResult = true}
  ) async{
    batch = (await initializeDB()).batch();

    for (var operation in operations){ operation(); }

    return await batch.commit(noResult: noResult);
  }

  void insertItinerary(Itinerary data) {
    batch.insert(
        _itinerariesTableName,
        data.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace
    );
  }

  void insertActivity(Activity data) {
    batch.insert(
        _activitiesTableName ,
        data.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace
    );
  }

  void insertDay(Day data) {
    batch.insert(
        _daysTableName,
        data.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace
    );
  }

  void deleteItinerary(int id) {
    _deleteDataWithId(id, _itinerariesTableName);
  }

  void deleteActivity(int id) {
    _deleteDataWithId(id, _activitiesTableName);
  }

  void deleteDay(int id) {
    _deleteDataWithId(id, _daysTableName);
  }

  void _deleteDataWithId(int id , String tableName) {
    batch.delete(
        tableName,
        where: "id = ?",
        whereArgs: [id]
    );
  }
  
  Future<List<Map<String , Object?>>> getItineraries() async {
    final db = await initializeDB();
    return db.query(_itinerariesTableName);
  }
  // Future<void> insertItinerary(Itinerary data) async{
  //   final db = await initializeDB();
  //   db.batch();
  //   await db.insert(
  //       _itinerariesTableName ,
  //       data.toMap(),
  //       conflictAlgorithm: ConflictAlgorithm.replace
  //   );
  // }
  //
  // Future<void> insertActivity(Activity data) async{
  //   final db = await initializeDB();
  //   await db.insert(
  //       _activitiesTableName ,
  //       data.toMap(),
  //       conflictAlgorithm: ConflictAlgorithm.replace
  //   );
  // }
  //
  // Future<void> insertDay(Day data) async{
  //   final db = await initializeDB();
  //   await db.insert(
  //       _daysTableName,
  //       data.toMap(),
  //       conflictAlgorithm: ConflictAlgorithm.replace
  //   );
  // }
  //
  // Future<void> deleteItinerary(int id) async{
  //   await _deleteDataWithId(id, _itinerariesTableName);
  // }
  //
  // Future<void> deleteActivity(int id) async{
  //   await _deleteDataWithId(id, _activitiesTableName);
  // }
  //
  // Future<void> deleteDay(int id) async{
  //   await _deleteDataWithId(id, _daysTableName);
  // }
  //
  // Future<void> _deleteDataWithId(int id , String tableName) async{
  //   final db = await initializeDB();
  //   await db.delete(
  //     tableName,
  //     where: "id = ?",
  //     whereArgs: [id]
  //   );
  // }
}