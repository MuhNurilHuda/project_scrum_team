
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../model/itinerary.dart';

class DatabaseService{
  static const _dbName = 'itinerary_db';
  static const _itinerariesTableName = "itineraries";

  static Future<Database> initializeDB() async {
    return openDatabase(
      join(await getDatabasesPath() , _dbName),
      onCreate: (database, version) async {
        await database.execute(
            "CREATE TABLE $_itinerariesTableName("
                "id STRING PRIMARY KEY,"
                "data STRING"
            ")"
        );
      },
      version: 2,
    );
  }

  Future<void> insertItinerary(Itinerary data) async{
    (await initializeDB()).insert(
        _itinerariesTableName,
        data.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace
    );
  }

  Future<List<Itinerary>> fetchItineraries() async{
    final db = await initializeDB();

    return (await db.query(_itinerariesTableName)).map(
      (json) => Itinerary.fromJson(json)
    ).toList();
  }
}