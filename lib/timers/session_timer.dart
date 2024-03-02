import 'dart:async';

import 'package:flutter/material.dart';
import 'package:mq_safety_first/config/text_styling_size.dart';

class SessionTimer extends StatefulWidget {
  const SessionTimer({super.key});

  @override
  State<SessionTimer> createState() => _SessionTimerState();
}

class _SessionTimerState extends State<SessionTimer> {
  late StreamSubscription<int> _timerSubscription;
  int _secondsRemaining = 0;

  @override
  void initState() {
    super.initState();
    _timerSubscription =
        SessionTimerManager.countdownStream().listen((seconds) {
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
    final hours = _secondsRemaining ~/ 3600;
    final minutes = (_secondsRemaining % 3600) ~/ 60;
    final seconds = _secondsRemaining % 60;

    final formattedTime =
        '${hours.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';

    return RichText(
      text: TextSpan(
        children: <TextSpan>[
          const TextSpan(
            text: 'Session Time: ',
            style: textStyle20Black,
          ),
          TextSpan(
            text: formattedTime, // Your formatted time here
            style: textStyle20Green, // Specific style for the time
          ),
        ],
      ),
    );
  }
}

class SessionTimerManager {
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