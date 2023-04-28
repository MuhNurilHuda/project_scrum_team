
import 'dart:convert';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:developer' as developer;
import '../model/itinerary.dart';

class DatabaseService{
  static const _dbName = 'itinerary_db';
  static const _itinerariesTableName = "itineraries";

  static final DatabaseService _singletonInstance = DatabaseService
      ._internalConstructor();
  factory DatabaseService() {
    return _singletonInstance;
  }
 DatabaseService._internalConstructor();


  Database? _database;

  Future<Database> get database async{
    _database ??= await openDatabase(
        join(await getDatabasesPath() , _dbName),
        onCreate: (database, version) async {
          await database.execute(
              "CREATE TABLE $_itinerariesTableName("
                  "id STRING PRIMARY KEY,"
                  "data STRING"
                  ")"
          );
        },
        version: 1,
      );
    return _database!;
  }

  Future<void> insertItinerary(Itinerary itinerary) async{
    try {

      final Map<String , String> dataMap = {
        "id" : itinerary.id,
        "data" : jsonEncode(itinerary.toJson())
      };

      // developer.log("Mencoba insert" , name : "qqq");

      final db = await database;

      // final tables = await db.query("sqlite_master", where: "type = 'table'");
      // for (final table in tables) {
      //   developer.log("Nama Table : ${table["name"]}" , name : "qqq");
      // }

      await db.insert(
          _itinerariesTableName,
          dataMap,
          conflictAlgorithm: ConflictAlgorithm.replace
      );
       // developer.log("Berhasil insert" , name : "qqq");
    } catch(e){
      developer.log(e.toString() , name : "qqq");
    }
  }

  Future<List<Itinerary>> fetchItineraries({
    String filterItineraryName = "",
  }) async{
    try {
      final db = await database;

      final hasilQuery = (await db.query(_itinerariesTableName)).map(
              (rawData){
                final jsonString = rawData['data']!.toString();
                // developer.log("Object : $jsonString" , name: "qqq");
                return Itinerary.fromJson(jsonDecode(jsonString));
              }
      ).where(
          (itinerary){
            return itinerary.title.contains(RegExp(filterItineraryName , caseSensitive: false));
          }
      ).toList();


      return hasilQuery;
    } catch(e){
      developer.log(e.toString() , name : "qqq");
      rethrow;
    }
  }

  Future<void> deleteItinerary(String id) async{
    final db = await database;

    await db.delete(
        _itinerariesTableName ,
        where: "id = ?",
        whereArgs: [id]
    );
  }
}