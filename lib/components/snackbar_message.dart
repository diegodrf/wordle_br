import 'package:flutter/material.dart';
import 'package:wordle_br/constants.dart';

class SnackBarMessage extends StatelessWidget {
  final String message;

  const SnackBarMessage({Key? key, required this.message}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SnackBar(
      content: Text(message),
      duration: kSnackBarMessageDuration,
    );
  }
}
