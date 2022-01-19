import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wordle_br/utils/utils.dart';

class Keyboard extends StatelessWidget {
  final VoidCallback callbackNotify;
  const Keyboard({Key? key, required this.callbackNotify}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        generateKeyboardButtons(0, callbackNotify),
        generateKeyboardButtons(1, callbackNotify),
        generateKeyboardButtons(2, callbackNotify),
      ],
    );
  }
}
