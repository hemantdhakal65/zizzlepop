import 'package:flutter/material.dart';
import 'package:zizzlepop/utils/constants.dart';

class OptionButton extends StatelessWidget {
  final String text;
  final bool isSelected;
  final bool isCorrect;
  final bool isWrong;
  final VoidCallback onPressed;

  const OptionButton({
    super.key,
    required this.text,
    required this.isSelected,
    required this.isCorrect,
    required this.isWrong,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    Color backgroundColor = Colors.white;
    Color borderColor = Colors.grey;
    Color textColor = kTextColor;

    if (isSelected) {
      backgroundColor = Color.fromRGBO(
        (kPrimaryColor.red * 255).round(),
        (kPrimaryColor.green * 255).round(),
        (kPrimaryColor.blue * 255).round(),
        0.1,
      );
      borderColor = kPrimaryColor;
      textColor = kPrimaryColor;
    }

    if (isCorrect) {
      backgroundColor = Color.fromRGBO(
        (Colors.green.red * 255).round(),
        (Colors.green.green * 255).round(),
        (Colors.green.blue * 255).round(),
        0.1,
      );
      borderColor = Colors.green;
      textColor = Colors.green;
    }

    if (isWrong) {
      backgroundColor = Color.fromRGBO(
        (Colors.red.red * 255).round(),
        (Colors.red.green * 255).round(),
        (Colors.red.blue * 255).round(),
        0.1,
      );
      borderColor = Colors.red;
      textColor = Colors.red;
    }

    return OutlinedButton(
      onPressed: onPressed,
      style: OutlinedButton.styleFrom(
        backgroundColor: backgroundColor,
        side: BorderSide(color: borderColor, width: 2),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
      ),
      child: Row(
        children: [
          if (isCorrect || isWrong)
            Icon(
              isCorrect ? Icons.check_circle : Icons.cancel,
              color: isCorrect ? Colors.green : Colors.red,
            ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              text,
              style: TextStyle(
                fontSize: 16,
                color: textColor,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          ),
        ],
      ),
    );
  }
}