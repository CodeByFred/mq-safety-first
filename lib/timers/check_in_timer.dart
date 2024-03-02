import 'dart:async';

import 'package:flutter/material.dart';

import '../config/text_styling_size.dart';

class CheckInTimer extends StatefulWidget {
  const CheckInTimer({super.key});

  @override
  State<CheckInTimer> createState() => _CheckInTimerState();
}

class _CheckInTimerState extends State<CheckInTimer> {
  late StreamSubscription<int> _timerSubscription;
  int _secondsRemaining = CheckInTimerManager.secondsRemaining;

  @override
  void initState() {
    super.initState();
    _timerSubscription =
        CheckInTimerManager.countdownStream().listen((seconds) {
      setState(() {
        _secondsRemaining = seconds;
      });
    });
  }

  @override
  void dispose() {
    _timerSubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Determine if the time is negative (past the countdown)
    bool isNegative = _secondsRemaining < 0;
    // Calculate minutes and seconds from the absolute value of _secondsRemaining
    int totalSeconds = isNegative ? -_secondsRemaining : _secondsRemaining;
    final minutes = totalSeconds ~/ 60;
    final seconds = totalSeconds % 60;

    // Format the time as "MM:SS", adding a '-' prefix if the time is negative
    final formattedTime =
        '${isNegative ? '-' : ''}${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';

    return Text(
      formattedTime,
      style: isNegative? textStyle20Red : textStyle20Green,
    );
  }
}

class CheckInTimerManager {
  static int secondsRemaining = 0;
  static late int lastSelectedTime;

  static void setTimer(int seconds) {
    lastSelectedTime = seconds;
    secondsRemaining = seconds;
  }

  static Stream<int> countdownStream() {
    return Stream.periodic(const Duration(seconds: 1),
        (x) => secondsRemaining = secondsRemaining - 1);
  }
}