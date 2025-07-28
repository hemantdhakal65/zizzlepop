import 'package:flutter/material.dart';
import 'package:zizzlepop/screens/zizzlepop/modes/quiz_mode/components/option_button.dart';
import 'package:zizzlepop/utils/constants.dart';

class QuestionCard extends StatelessWidget {
  final Map<String, dynamic> question;
  final int? selectedOption;
  final bool showSolution;
  final Function(int) onOptionSelected;

  const QuestionCard({
    super.key,
    required this.question,
    required this.selectedOption,
    required this.showSolution,
    required this.onOptionSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              question['question'],
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            Text(
              'Difficulty: ${question['difficulty']}',
              style: TextStyle(
                color: _getDifficultyColor(question['difficulty']),
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            ..._buildOptions(),
            if (showSolution && selectedOption != null) ...[
              const SizedBox(height: 20),
              Container(
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: selectedOption == question['correctIndex']
                      ? Colors.green[50]
                      : Colors.red[50],
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Explanation:',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: kTextColor,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      question['explanation'],
                      style: TextStyle(color: kTextColor),
                    ),
                  ],
                ),
              ),
            ]
          ],
        ),
      ),
    );
  }

  List<Widget> _buildOptions() {
    final options = List<String>.from(question['options']);
    return options.asMap().entries.map((entry) {
      final index = entry.key;
      final option = entry.value;

      return Padding(
        padding: const EdgeInsets.only(bottom: 10),
        child: OptionButton(
          text: option,
          isSelected: selectedOption == index,
          isCorrect: showSolution && index == question['correctIndex'],
          isWrong: showSolution && selectedOption == index &&
              selectedOption != question['correctIndex'],
          onPressed: () => onOptionSelected(index),
        ),
      );
    }).toList();
  }

  Color _getDifficultyColor(String difficulty) {
    switch (difficulty.toLowerCase()) {
      case 'easy': return Colors.green;
      case 'medium': return Colors.orange;
      case 'hard': return Colors.red;
      default: return kSecondaryColor;
    }
  }
}