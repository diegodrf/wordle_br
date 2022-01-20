import 'dart:async';
import 'package:flutter/material.dart';
import 'package:wordle_br/models/game_match.dart';
import 'package:wordle_br/services/repository/local/database.dart';

class SuccessDialog extends StatefulWidget {
  const SuccessDialog({Key? key}) : super(key: key);

  @override
  _SuccessDialogState createState() => _SuccessDialogState();
}

class _SuccessDialogState extends State<SuccessDialog> {
  int _numOfGamesPlayed = 0;
  double _winPercentage = 0;

  int _successByAttemptIndex1 = 1;
  int _successByAttemptIndex2 = 1;
  int _successByAttemptIndex3 = 1;
  int _successByAttemptIndex4 = 1;
  int _successByAttemptIndex5 = 1;
  int _successByAttemptIndex6 = 0;

  Future _setVariables() async {
    List<GameMatch> gameMatches = await LocalDatabase.getAllGameMatches();
    int numOfSuccess = await LocalDatabase.getNumberOfGameMatchWithSuccess();
    _winPercentage = numOfSuccess * 100 / gameMatches.length;
    _numOfGamesPlayed = gameMatches.length;

    _successByAttemptIndex1 =
        await LocalDatabase.getNumberOfGameMatchWithSuccessPerAttempts(1);
    _successByAttemptIndex2 =
        await LocalDatabase.getNumberOfGameMatchWithSuccessPerAttempts(2);
    _successByAttemptIndex3 =
        await LocalDatabase.getNumberOfGameMatchWithSuccessPerAttempts(3);
    _successByAttemptIndex4 =
        await LocalDatabase.getNumberOfGameMatchWithSuccessPerAttempts(4);
    _successByAttemptIndex5 =
        await LocalDatabase.getNumberOfGameMatchWithSuccessPerAttempts(5);
    _successByAttemptIndex6 =
        await LocalDatabase.getNumberOfGameMatchWithSuccessPerAttempts(6);

    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    _setVariables();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: 360.0,
        width: double.infinity,
        margin: const EdgeInsets.symmetric(horizontal: 20.0),
        padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 30.0),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(
            Radius.circular(10.0),
          ),
        ),
        child: Column(
          children: [
            const Text(
              'STATISTICS',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Statistics(value: _numOfGamesPlayed, description: 'Played'),
                Statistics(value: _winPercentage.toInt(), description: 'Win %'),
                const Statistics(value: 1, description: 'Current Streak'),
                const Statistics(value: 1, description: 'Max Streak'),
              ],
            ),
            const SizedBox(
              height: 10.0,
            ),
            const Text(
              'GUESS DISTRIBUTION',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            SuccessBarCounter(
                rowIndex: 1,
                value: _successByAttemptIndex1,
                maxValue: _numOfGamesPlayed),
            SuccessBarCounter(
                rowIndex: 2,
                value: _successByAttemptIndex2,
                maxValue: _numOfGamesPlayed),
            SuccessBarCounter(
                rowIndex: 3,
                value: _successByAttemptIndex3,
                maxValue: _numOfGamesPlayed),
            SuccessBarCounter(
                rowIndex: 4,
                value: _successByAttemptIndex4,
                maxValue: _numOfGamesPlayed),
            SuccessBarCounter(
                rowIndex: 5,
                value: _successByAttemptIndex5,
                maxValue: _numOfGamesPlayed),
            SuccessBarCounter(
                rowIndex: 6,
                value: _successByAttemptIndex6,
                maxValue: _numOfGamesPlayed),
            const SizedBox(
              height: 10.0,
            ),
            Row(
              children: [
                const NextWordCounter(),
                Container(
                  color: Colors.black,
                  height: 60.0,
                  width: 1,
                  margin: const EdgeInsets.symmetric(horizontal: 30.0),
                ),
                GestureDetector(
                  child: Container(
                    height: 40.0,
                    width: 100,
                    decoration: const BoxDecoration(
                        color: Color(0xFF6AAA64),
                        borderRadius: BorderRadius.all(Radius.circular(5.0))),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Text(
                          'SHARE',
                          style: TextStyle(
                            fontWeight: FontWeight.w800,
                            color: Colors.white,
                          ),
                        ),
                        Icon(
                          Icons.share_outlined,
                          color: Colors.white,
                        )
                      ],
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}

class Statistics extends StatelessWidget {
  final int value;
  final String description;

  const Statistics({Key? key, required this.value, required this.description})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(5.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            value.toString(),
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 32.0),
          ),
          Text(
            description,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

class NextWordCounter extends StatefulWidget {
  const NextWordCounter({Key? key}) : super(key: key);

  @override
  _NextWordCounterState createState() => _NextWordCounterState();
}

class _NextWordCounterState extends State<NextWordCounter> {
  Duration _timeRemainingToNextWordleBR = const Duration(days: 0);
  late final Timer _timeCounter;

  Future _timer() async {
    _timeCounter = Timer.periodic(const Duration(seconds: 1), (timer) {
      Timer.run(() {
        DateTime _now = DateTime.now().toLocal();
        DateTime _tomorrow =
            DateTime.now().add(const Duration(days: 1)).toLocal();

        setState(() {
          _timeRemainingToNextWordleBR =
              DateTime(_tomorrow.year, _tomorrow.month, _tomorrow.day)
                  .difference(_now);
        });
      });
    });
  }

  @override
  void initState() {
    super.initState();
    _timer();
  }

  @override
  void dispose() {
    _timeCounter.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text(
          'NEXT WORDLE BR',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          _timeRemainingToNextWordleBR.toString().split('.')[0],
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 32.0),
        ),
      ],
    );
  }
}

class SuccessBarCounter extends StatelessWidget {
  final int rowIndex;
  final int value;
  final int maxValue;
  late final int _valueInPercentage;

  void _calculatePercentage() {
    try {
      _valueInPercentage = value * 100 ~/ maxValue;
    } on UnsupportedError catch (e) {
      _valueInPercentage = 0;
      Map<String, dynamic> message = {
        'rowIndex': rowIndex,
        'value': value,
        'maxValue': maxValue,
        '_valueInPercentage': _valueInPercentage,
        'error': e
      };
      print(message);
    }
  }

  SuccessBarCounter({
    Key? key,
    required this.rowIndex,
    required this.value,
    required this.maxValue,
  }) : super(key: key) {
    _calculatePercentage();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 2.0),
      child: Row(
        children: [
          Container(
              margin: const EdgeInsets.only(right: 3.0),
              child: Text(rowIndex.toString())),
          Expanded(
            flex: _valueInPercentage,
            child: Container(
              height: 20,
              color:
                  value > 0 ? const Color(0xFF6AAA64) : const Color(0xFF787C7E),
              child: Padding(
                padding: const EdgeInsets.all(3.0),
                child: Text(
                  value.toString(),
                  textAlign: TextAlign.end,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            flex: (100 - _valueInPercentage).toInt(),
            child: Container(
              height: 20,
              color: Colors.white,
            ),
          )
        ],
      ),
    );
  }
}
