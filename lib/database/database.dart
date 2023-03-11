import 'package:flutter/material.dart';
import 'package:iterasi1/model/activity_list.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

abstract class DatabaseProvider {
  static Database? _database;

  static Future<Database> open() async {
    if(_database == null) {
      final databasesPath = await getDatabasesPath();
      final path = join(databasesPath, 'my_database.db');
      _database = await openDatabase(
        path,
        version: 1,
        onCreate: (Database db, int version) async {
          await db.execute(
            'CREATE TABLE activities (id INTEGER PRIMARY KEY, activity_time TEXT, activity_name TEXT)'
          );
        }
      );
    }
    return _database!;
  }

  static Future close() async {
    if(_database != null) {
      await _database!.close();
      _database = null;
    }
  }
}

class DatabaseHelper extends DatabaseProvider {
  static const activitiesTable = 'activities';

  static Future<List<Map<String, dynamic>>> getActivities() async {
    final db = await DatabaseProvider.open();
    return db.query(activitiesTable);
  }

  static Future<void> insertActivity(Activity activity) async {
    final db = await DatabaseProvider.open();
    await db.insert(
      activitiesTable,
      activity.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  static Future<void> updateActivity(Activity activity) async {
    final db = await DatabaseProvider.open();
    await db.update(
      activitiesTable,
      activity.toMap(),
      where: 'id= ?',
      whereArgs: [activity.id],
    );
  }

  static Future<void> deleteActivity(Activity activity) async {
    final db = await DatabaseProvider.open();
    await db.delete(
      activitiesTable,
      where: 'id= ?',
      whereArgs: [activity.id],
    );
  }
}