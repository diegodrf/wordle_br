import 'package:flutter/material.dart';
import 'package:wordle_br/core/ui_brain.dart';
import 'package:wordle_br/core/wordlebr_brain.dart';
import 'package:wordle_br/models/game_match.dart';
import 'package:wordle_br/models/wordlebr_model.dart';
import 'package:wordle_br/services/repository/local/database.dart';
import 'package:wordle_br/services/wordle_api.dart';
import 'package:wordle_br/components/success_dialog.dart';
import 'package:wordle_br/utils/utils.dart';
import 'package:wordle_br/constants.dart';
import 'package:flutter/services.dart';

class KeyboardButton extends StatefulWidget {
  final String letter;
  final VoidCallback callbackNotify;

  const KeyboardButton(
      {Key? key, required this.letter, required this.callbackNotify})
      : super(key: key);

  @override
  _KeyboardButtonState createState() => _KeyboardButtonState();
}

class _KeyboardButtonState extends State<KeyboardButton> {
  final WordleBRBrain wordleBRBrain = WordleBRBrain.getInstance();
  final UIBrain uiBrain = UIBrain.getInstance();

  Future<WordleBRModel?> submitWord(String word) async {
    WordleApi wordleApi = WordleApi();
    WordleBRModel? wordleBRModel;
    try {
      wordleBRModel = await wordleApi.postWord(word);
    } on InvalidWordError catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.message),
          duration: kSnackBarMessageDuration,
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.toString()),
          duration: kSnackBarMessageDuration,
        ),
      );
    }
    return wordleBRModel;
  }

  Future showSuccessDialog() async {
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return const SuccessDialog();
      },
    );
  }

  // flex: widget.letter == kEnterButtonLabel || widget.letter == kBackSpaceSymbol ? 2 : 1,
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        HapticFeedback.vibrate();

        String _letter = widget.letter.toUpperCase();
        int _index = wordleBRBrain.getWordAttemptIndex();

        if (_letter == kBackSpaceSymbol) {
          setState(() {
            wordleBRBrain.removeLastLetter(_index);
            widget.callbackNotify();
          });
        } else if (_letter == 'ENTER') {
          // Show Progress bar

          String _word = wordleBRBrain.getWord(_index);
          if (_word.length == 5) {
            uiBrain.showProgressBar = true;
            widget.callbackNotify();
            WordleBRModel? wordleBRModel =
                await submitWord(wordleBRBrain.getWord(_index));
            if (wordleBRModel != null) {
              wordleBRBrain.updateResult(wordleBRModel.result);
              wordleBRBrain.incrementAttemptIndex();
            }
            uiBrain.showProgressBar = false;
            widget.callbackNotify();
            if (wordleBRBrain
                // Success. Discovered the word
                .getResult(_index)
                .every((element) => element == 1)) {
              var allGameMatches = await LocalDatabase.getAllGameMatches();
              allGameMatches.sort((a, b) => a.id!.compareTo(b.id!));
              GameMatch lastGameMatch = allGameMatches.last;
              lastGameMatch.success = 1;
              lastGameMatch.attempts = _index + 1;
              await LocalDatabase.updateGameMatch(lastGameMatch);

              await showSuccessDialog();
            }
            if (wordleBRBrain.getWordAttemptIndex() == 6 &&
                // Fail. Used all attempts and didn't discover de word
                wordleBRBrain
                    .getResult(_index)
                    .any((element) => element != 1)) {
              await showSuccessDialog();
            }
          }
        } else {
          setState(() {
            wordleBRBrain.addLetter(_index, _letter);
            widget.callbackNotify();
          });
        }
      },
      child: Container(
        margin: const EdgeInsets.all(2.0),
        height: 48.0,
        width: widget.letter == kEnterButtonLabel ||
                widget.letter == kBackSpaceSymbol
            ? 50
            : 32,
        decoration: BoxDecoration(
          color: setKeyboardLetterColor(
              widget.letter.toUpperCase(), wordleBRBrain.letterStatus),
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Center(
          child: Text(
            widget.letter.toUpperCase(),
            style: const TextStyle(
              // fontSize: 20.0,
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
