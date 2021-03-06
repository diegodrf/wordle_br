import 'package:flutter/material.dart';
import 'package:wordle_br/screens/game_page.dart';
import 'package:wordle_br/services/repository/local/database.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await LocalDatabase.startDatabase();
  runApp(const WordleBr());
}

class WordleBr extends StatelessWidget {
  const WordleBr({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: SafeArea(
        child: Scaffold(
          body: GamePage(),
        ),
      ),
    );
  }
}

