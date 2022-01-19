import 'package:flutter/material.dart';
import 'package:wordle_br/constants.dart';

class GameTitle extends StatelessWidget {
  const GameTitle({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: const [
        Icon(
          Icons.help_outline,
          color: kIconColor,
        ),
        Text(
          'WORDLE BR',
          style: kGameTitleStyle,
        ),
        Icon(
          Icons.settings,
          color: kIconColor,
        )
      ],
    );
  }
}
