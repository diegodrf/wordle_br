class GameMatch {
  int? id;

  // Sqflite don't allow datetime type, so timestamp field store time as epoch
  final int timestamp;

  // Sqflite don't allow bool type, so success field store bool as int 0 or 1
  final int success;
  final int attempts;

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
}
