
import 'dart:convert';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:developer' as developer;
import '../model/itinerary.dart';

class DatabaseService{
  static const _dbName = 'itinerary_db';
  static const _itinerariesTableName = "itineraries";

  static Future<Database> initializeDB() async {
    return openDatabase(
      join(await getDatabasesPath() , _dbName),
      onCreate: (database, version) async {
        developer.log("Mencoba create table" , name: "qqq");
        await database.execute(
            "CREATE TABLE $_itinerariesTableName("
                "id STRING PRIMARY KEY,"
                "data STRING"
            ")"
        );
        developer.log("Berhasil create table" , name: "qqq");
      },
      // onUpgrade: (Database db, int oldVersion, int newVersion) async {
      //     if (oldVersion < newVersion) {
      //       developer.log("onUpgrade , old : $oldVersion, new : $newVersion" , name : "qqq");
      //
      //       final tables = await db.query("sqlite_master", where: "type = 'table'");
      //       for (final table in tables) {
      //         await db.execute("DROP TABLE IF EXISTS ${table["name"]}");
      //       }
      //     }
      // },
      version: 1,
    );
  }

  Future<void> insertItinerary(Itinerary itinerary) async{
    try {

      final Map<String , String> dataMap = {
        "id" : itinerary.id,
        "data" : jsonEncode(itinerary.toJson())
      };

      developer.log("Mencoba insert" , name : "qqq");

      final db = await initializeDB();

      final tables = await db.query("sqlite_master", where: "type = 'table'");
      for (final table in tables) {
        developer.log("Nama Table : ${table["name"]}" , name : "qqq");
      }

      await db.insert(
          _itinerariesTableName,
          dataMap,
          conflictAlgorithm: ConflictAlgorithm.replace
      );
       developer.log("Berhasil insert" , name : "qqq");
    } catch(e){
      developer.log(e.toString() , name : "qqq");
    }
  }

  Future<List<Itinerary>> fetchItineraries() async{
    try {
      final db = await initializeDB();
      developer.log("Mencoba ngefetch" , name : "qqq");

      final hasilQuery = (await db.query(_itinerariesTableName)).map(
              (rawData){
                final jsonString = rawData['data']!.toString();
                developer.log("Object : $jsonString" , name: "qqq");
                return Itinerary.fromJson(jsonDecode(jsonString));
              }
      ).toList();

      developer.log("Total query : ${hasilQuery.length}" , name: "qqq");

      return hasilQuery;
    } catch(e){
      developer.log(e.toString() , name : "qqq");
      rethrow;
    }
  }
}