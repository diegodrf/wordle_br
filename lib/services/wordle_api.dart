import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:wordle_br/models/wordlebr_model.dart';

class WordleApi {
  final String baseUrl = 'https://wordlebr.herokuapp.com/api/';

  WordleApi();

  Future<WordleBRModel> postWord(String word) async {
    String endpoint = 'guess';
    Uri url = Uri.parse(baseUrl + endpoint);
    Map<String, String> body = {'word': word.toLowerCase()};
    Map<String, String> headers = {'Content-Type': 'application/json'};
    http.Response response = await http.post(
      url,
      body: jsonEncode(body),
      headers: headers,
    );
    if (response.statusCode == 200) {
      dynamic _json = jsonDecode(response.body);
      return WordleBRModel.fromJson(_json);
    } else if (response.statusCode == 400) {
      throw InvalidWordError('"Palavra não existe');
    } else {
      String message = {'StatusCode': response.statusCode}.toString();
      throw Exception(message);
    }
  }
}

class InvalidWordError implements Exception {
  String message;
  InvalidWordError(this.message);

  @override
  String toString() {
    return message;
  }
}
