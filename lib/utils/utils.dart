import 'package:flutter/material.dart';
import 'package:wordle_br/components/keyboard_button.dart';
import 'package:wordle_br/components/letter_box.dart';
import 'package:wordle_br/constants.dart';

Row generateKeyboardButtons(int keyboardRow, VoidCallback callbackNotify) {
  int keyboardRowSize = kKeyboardLetters[keyboardRow].length;

  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: List<KeyboardButton>.generate(
      keyboardRowSize,
      (index) {
        return KeyboardButton(
          letter: kKeyboardLetters[keyboardRow][index],
          callbackNotify: callbackNotify,
        );
      },
    ),
  );
}

Row generateWordAttemptRow(String text, List<dynamic> resultBackgroundList) {
  int rowSize = 5;
  List<String> splitString = text.split('');
  List<LetterBox> letterBoxes = [];

  for (int index = 0; index < rowSize; index++) {
    String _letter;
    int colorId = resultBackgroundList[index];
    try {
      _letter = splitString[index];
    } on RangeError {
      _letter = '';
    }

    LetterBox _letterBox = LetterBox(
      letter: _letter,
      boxBackground: setColor(colorId),
    );
    letterBoxes.add(_letterBox);
  }

  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: letterBoxes,
  );
}

Color setColor(int colorId) {
  if (colorId == 0) {
    return kBoxBackgroundFail;
  } else if (colorId == 1) {
    return kBoxBackgroundSuccess;
  } else if (colorId == 2) {
    return kBoxBackgroundHalfSuccess;
  } else {
    return kBoxBackgroundDefault;
  }
}

Color setKeyboardLetterColor(String letter, Map<int, Set<String>> resultMap) {
  if (resultMap[1]!.contains(letter)) {
    return kBoxBackgroundSuccess;
  } else if (resultMap[2]!.contains(letter)) {
    return kBoxBackgroundHalfSuccess;
  } else if (resultMap[0]!.contains(letter)) {
    return kBoxBackgroundFail;
  } else {
    return kBoxBackgroundKeyboardDefault;
  }
}
