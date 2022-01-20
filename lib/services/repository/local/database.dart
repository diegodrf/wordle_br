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
    print(gameMatches);
    return List.generate(
        gameMatches.length, (index) => GameMatch.fromMap(gameMatches[index]));
  }

  static Future<GameMatch> getGameMatch(int id) async {
    final List<Map<String, dynamic>> gameMatch = await database.query(
      TableGameMatches.tableName,
      where: '${TableGameMatches.columnId} = ?',
      whereArgs: [id],
    );
    return GameMatch.fromMap(gameMatch.first);
  }

  static Future<int> getNumberOfGameMatchWithSuccess() async {
    final List<Map<String, dynamic>> gameMatches = await database.query(
      TableGameMatches.tableName,
      where: '${TableGameMatches.columnSuccess} = ?',
      whereArgs: [1],
    );
    return gameMatches.length;
  }

  static Future<int> getNumberOfGameMatchWithFail() async {
    final List<Map<String, dynamic>> gameMatches = await database.query(
      TableGameMatches.tableName,
      where: '${TableGameMatches.columnSuccess} = ?',
      whereArgs: [0],
    );
    return gameMatches.length;
  }

  static Future updateGameMatch(GameMatch gameMatch) async {
    await database.update(
      TableGameMatches.tableName,
      gameMatch.toMap(),
      where: '${TableGameMatches.columnId} = ?',
      whereArgs: [gameMatch.id],
    );
  }
}
