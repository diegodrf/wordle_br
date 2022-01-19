import 'package:flutter/material.dart';
import 'package:wordle_br/constants.dart';

class LetterBox extends StatelessWidget {
  final String letter;
  final Color boxBackground;

  const LetterBox({Key? key, required this.letter, required this.boxBackground})
      : super(key: key);

  Color setBorderColor() {
    if (letter.isEmpty && boxBackground == kBoxBackgroundDefault) {
      return kLetterBoxBorderInactive;
    } else if (letter.isNotEmpty && boxBackground == kBoxBackgroundDefault) {
      return kLetterBoxBorderActive;
    } else {
      return boxBackground;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(3.0),
      height: 50.0,
      width: 50.0,
      decoration: BoxDecoration(
        color: boxBackground,
        border: Border.all(
          width: 2.0,
          color: setBorderColor(),
        ),
      ),
      child: Center(
        child: Text(
          letter.toUpperCase(),
          style: TextStyle(
            fontSize: 30.0,
            color: boxBackground == kBoxBackgroundDefault
                ? Colors.black
                : Colors.white,
            fontWeight: FontWeight.w900,
          ),
        ),
      ),
    );
  }
}
