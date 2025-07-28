import 'package:flutter/material.dart';

enum TimerType { progress, countdown }

class TimerWidget extends StatelessWidget {
  final int duration;
  final TimerType timerType;

  const TimerWidget({
    super.key,
    required this.duration,
    this.timerType = TimerType.progress,
  });

  @override
  Widget build(BuildContext context) {
    if (timerType == TimerType.progress) {
      return LinearProgressIndicator(
        value: duration / 30,
        minHeight: 10,
        backgroundColor: Colors.grey[300],
        valueColor: const AlwaysStoppedAnimation<Color>(Colors.blue),
        borderRadius: BorderRadius.circular(5),
      );
    } else {
      return Text(
        '$duration',
        style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
      );
    }
  }
}