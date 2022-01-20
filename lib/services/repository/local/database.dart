import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:flutter/material.dart';
import 'package:wordle_br/services/repository/local/constants.dart';

class LocalDatabase {
  static late final Future<Database> database;

  LocalDatabase._();

  static Future<void> startDatabase() async {
    WidgetsFlutterBinding.ensureInitialized();
    final String databasePath = join(await getDatabasesPath(), databaseName);
    database = openDatabase(
      databasePath,
      onCreate: _createTables,
      version: databaseVersion,
    );
  }

  static Future<void> _createTables(Database db, int version) async {
    await db.execute(
      '''CREATE TABLE ${TableGameMatches.tableName} (
      ${TableGameMatches.columnId} INTEGER PRIMARY KEY AUTOINCREMENT, 
      ${TableGameMatches.columnTimeStamp} INTEGER NOT NULL, 
      ${TableGameMatches.columnAttempts} INTEGER NOT NULL, 
      ${TableGameMatches.columnSuccess} INTEGER NOT NULL''',
    );
    print('End!');
  }
}
