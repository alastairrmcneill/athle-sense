import 'dart:async';

import 'package:flutter/material.dart';

class CountdownTimer extends StatefulWidget {
  const CountdownTimer({super.key});

  @override
  State<CountdownTimer> createState() => _CountdownTimerState();
}

class _CountdownTimerState extends State<CountdownTimer> {
  String countdownString = '';
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  @override
  void dispose() {
    super.dispose();
    _timer.cancel();
  }

  void startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      DateTime now = DateTime.now();
      DateTime tomorrow = DateTime(now.year, now.month, now.day).add(Duration(days: 1));

      Duration difference = tomorrow.difference(now);

      int hours = difference.inHours;
      int minutes = difference.inMinutes % 60;
      int seconds = difference.inSeconds % 60;

      String hoursString = hours < 10 ? '0${hours.toString()}' : hours.toString();
      String minutesString = minutes < 10 ? '0${minutes.toString()}' : minutes.toString();
      String secondsString = seconds < 10 ? '0${seconds.toString()}' : seconds.toString();

      setState(() {
        countdownString = '${hoursString}h ${minutesString}m ${secondsString}s';
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      countdownString,
      style: Theme.of(context).textTheme.headline5!.copyWith(fontSize: 32),
    );
  }
}
