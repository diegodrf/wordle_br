import 'package:flutter/material.dart';
import 'package:wordle_br/components/keyboard.dart';
import 'package:wordle_br/components/word_attempts_box.dart';
import 'package:wordle_br/components/game_title.dart';
import 'package:wordle_br/core/ui_brain.dart';
import 'package:wordle_br/core/wordlebr_brain.dart';

class GamePage extends StatefulWidget {
  const GamePage({Key? key}) : super(key: key);

  @override
  _GamePageState createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> with TickerProviderStateMixin {
  final WordleBRBrain wordleBRBrain = WordleBRBrain.getInstance();
  final UIBrain uiBrain = UIBrain.getInstance();
  late AnimationController animationController;

  void refresh() {
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
        vsync: this,
        duration: const Duration(seconds: 1),
        lowerBound: 0.0,
        upperBound: 1.0)
      ..addListener(() {
        setState(() {});
      });
    animationController.repeat();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const GameTitle(),
          Visibility(
            visible: uiBrain.showProgressBar,
            child: SizedBox(
              height: 1.5,
              child: LinearProgressIndicator(
                value: animationController.value,
              ),
            ),
          ),
          // const Divider(
          //   height: 1.0,
          //   thickness: 0.8,
          //   color: Color(0xFFD3D6DA),
          // ),
          WordAttemptsBox(words: wordleBRBrain.getAllWordAttempts()),
          Keyboard(callbackNotify: refresh),
        ],
      ),
    );
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }
}
