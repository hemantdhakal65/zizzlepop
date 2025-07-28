import 'package:flutter/material.dart';

class SoundButton extends StatelessWidget {
  final VoidCallback onPressed;
  final bool isActive;

  const SoundButton({
    super.key,
    required this.onPressed,
    this.isActive = false,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(
        Icons.volume_up,
        size: 40,
        color: isActive ? Colors.blue : Colors.grey,
      ),
      onPressed: onPressed,
    );
  }
}