const String databaseName = 'wordle_br.db';
const int databaseVersion = 1;
class TableGameMatches {
  static const String tableName = 'game_matches';
  static const String columnId = 'id';
  static const String columnTimeStamp = 'timestamp';
  static const String columnSuccess = 'success';
  static const String columnAttempts = 'attempts';
}