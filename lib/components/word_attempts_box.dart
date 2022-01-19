import 'package:flutter/material.dart';
import 'package:wordle_br/utils/utils.dart';
import 'package:wordle_br/core/wordlebr_brain.dart';

class WordAttemptsBox extends StatelessWidget {
  final List<String> words;
  final WordleBRBrain wordleBRBrain = WordleBRBrain.getInstance();

  WordAttemptsBox({Key? key, required this.words}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        generateWordAttemptRow(wordleBRBrain.getWord(0), wordleBRBrain.getResult(0)),
        generateWordAttemptRow(wordleBRBrain.getWord(1), wordleBRBrain.getResult(1)),
        generateWordAttemptRow(wordleBRBrain.getWord(2), wordleBRBrain.getResult(2)),
        generateWordAttemptRow(wordleBRBrain.getWord(3), wordleBRBrain.getResult(3)),
        generateWordAttemptRow(wordleBRBrain.getWord(4), wordleBRBrain.getResult(4)),
        generateWordAttemptRow(wordleBRBrain.getWord(5), wordleBRBrain.getResult(5)),
      ],
    );
  }
}
