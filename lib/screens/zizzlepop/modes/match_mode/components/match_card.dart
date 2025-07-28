import 'package:flutter/material.dart';

class MatchCard extends StatelessWidget {
  final String item;
  final bool isSelected;
  final bool isCorrect;
  final VoidCallback onTap;
  final String type;

  const MatchCard({
    super.key,
    required this.item,
    required this.isSelected,
    required this.isCorrect,
    required this.onTap,
    required this.type,
  });

  @override
  Widget build(BuildContext context) {
    Color backgroundColor = Colors.white;
    Color borderColor = Colors.grey;

    if (isSelected) {
      backgroundColor = isCorrect ? Colors.green.shade100 : Colors.red.shade100;
      borderColor = isCorrect ? Colors.green : Colors.red;
    }

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: borderColor, width: 2),
        ),
        child: type == 'emoji'
            ? Text(item, style: const TextStyle(fontSize: 40))
            : Text(item, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
      ),
    );
  }
}