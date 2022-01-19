class WordleBRModel {
  final List<dynamic> result;
  final String word;

  WordleBRModel({required this.result, required this.word});

  factory WordleBRModel.fromJson(Map<String, dynamic> json) {
    return WordleBRModel(
      result: json['result'] as List<dynamic>,
      word: json['word'] as String,
    );
  }
}
