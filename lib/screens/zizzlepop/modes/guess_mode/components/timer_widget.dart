import 'package:flutter/material.dart';

enum TimerType { progress, countdown }

class TimerWidget extends StatefulWidget {
  final int duration;
  final VoidCallback onComplete;
  final TimerType timerType;

  const TimerWidget({
    super.key,
    required this.duration,
    required this.onComplete,
    this.timerType = TimerType.countdown,
  });

  @override
  _TimerWidgetState createState() => _TimerWidgetState();
}

class _TimerWidgetState extends State<TimerWidget>
    with TickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: widget.duration),
    )..addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        widget.onComplete();
      }
    });
    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          if (widget.timerType == TimerType.progress) {
            return LinearProgressIndicator(
              value: _controller.value,
              minHeight: 10,
              backgroundColor: Colors.grey[300],
              valueColor: const AlwaysStoppedAnimation<Color>(Colors.red),
            );
          } else {
            return Text(
              '${(widget.duration - (_controller.value * widget.duration)).toInt()}s',
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            );
          }
        },
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}