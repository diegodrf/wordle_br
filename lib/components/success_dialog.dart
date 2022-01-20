import 'dart:async';
import 'package:flutter/material.dart';

class SuccessDialog extends StatelessWidget {
  final int numOfGamesPlayed;
  final double winPercentage;

  const SuccessDialog({
    Key? key,
    required this.numOfGamesPlayed,
    required this.winPercentage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
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
            Statistics(value: numOfGamesPlayed, description: 'Played'),
            Statistics(value: winPercentage.toInt(), description: 'Win %'),
            const Statistics(value: 1, description: 'Current Streak'),
            const Statistics(value: 1, description: 'Max Streak'),
          ],
        ),
        const Text(
          'GUESS DISTRIBUTION',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        Row(
          children: [
            const NextWordCounter(),
            TextButton(
              onPressed: () {},
              child: const Text('SHARE'),
            )
          ],
        )
      ],
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
