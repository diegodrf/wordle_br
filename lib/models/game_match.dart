class GameMatch {
  int? id;

  // Sqflite don't allow datetime type, so timestamp field store time as epoch
  final int timestamp;

  // Sqflite don't allow bool type, so success field store bool as int 0 or 1
  int success;

  int attempts;

  GameMatch({
    this.id,
    required this.timestamp,
    required this.success,
    required this.attempts,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'timestamp': timestamp,
      'success': success,
      'attempts': attempts
    };
  }

  DateTime getTimestampAsDateTime() {
    return DateTime.fromMillisecondsSinceEpoch(timestamp);
  }

  factory GameMatch.fromMap(Map<String, dynamic> mapObject) {
    return GameMatch(
      id: mapObject['id'],
      timestamp: mapObject['timestamp'],
      success: mapObject['success'],
      attempts: mapObject['attempts'],
    );
  }

  @override
  String toString() {
    Map<String, dynamic> fields = {
      'id': id,
      'timestamp': timestamp,
      'timestampAsDateTime': getTimestampAsDateTime(),
      'success': success,
      'attempts': attempts
    };
    return 'GameMatch ${fields.toString()}';
  }
}
