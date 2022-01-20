import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:wordle_br/models/game_match.dart';
import 'package:wordle_br/services/repository/local/constants.dart';

class LocalDatabase {
  static late final Database database;

  LocalDatabase._();

  static Future<void> startDatabase() async {
    final String databasePath = join(await getDatabasesPath(), databaseName);
    database = await openDatabase(
      databasePath,
      onCreate: _createTables,
      version: databaseVersion,
    );
  }

  static Future _createTables(Database db, int version) async {
    await db.execute(
      '''CREATE TABLE ${TableGameMatches.tableName} (
      ${TableGameMatches.columnId} INTEGER PRIMARY KEY AUTOINCREMENT, 
      ${TableGameMatches.columnTimeStamp} INTEGER NOT NULL, 
      ${TableGameMatches.columnAttempts} INTEGER NOT NULL, 
      ${TableGameMatches.columnSuccess} INTEGER NOT NULL
      )''',
    );
  }

  static Future<void> insertGameMatch(GameMatch gameMatch) async {
    final Database db = database;
    await db.insert(TableGameMatches.tableName, gameMatch.toMap());
  }

  static Future<List<GameMatch>> getAllGameMatches() async {
    final List<Map<String, dynamic>> gameMatches =
        await database.query(TableGameMatches.tableName);

    return List.generate(
        gameMatches.length, (index) => GameMatch.fromMap(gameMatches[index]));
  }
}
