import 'package:flutter/material.dart';

const String kBackSpaceSymbol = '\u232B';
const String kEnterButtonLabel = 'ENTER';
const List<List<String>> kKeyboardLetters = [
  ['q', 'w', 'e', 'r', 't', 'y', 'u', 'i', 'o', 'p'],
  ['a', 's', 'd', 'f', 'g', 'h', 'j', 'k', 'l'],
  [kEnterButtonLabel, 'z', 'x', 'c', 'v', 'b', 'n', 'm', kBackSpaceSymbol]
];

const Color kIconColor = Color(0xFF96999A);

const Color kLetterBoxBorderActive = Color(0xFF878A8C);
const Color kLetterBoxBorderInactive = Color(0xFFD3D6DA);

const Color kBoxBackgroundSuccess = Color(0xFF6AAA64);
const Color kBoxBackgroundFail = Color(0xFF787C7E);
const Color kBoxBackgroundHalfSuccess = Color(0xFFC9B458);
const Color kBoxBackgroundDefault = Color(0xFFFFFFFF);
const Color kBoxBackgroundKeyboardDefault = Color(0xFFD3D6DA);

const TextStyle kGameTitleStyle = TextStyle(
  fontSize: 30.0,
  fontWeight: FontWeight.bold,
);

const Duration kSnackBarMessageDuration =
    Duration(seconds: 1, milliseconds: 500);
