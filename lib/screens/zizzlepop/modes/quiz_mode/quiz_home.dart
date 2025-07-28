import 'package:flutter/material.dart';
import 'package:zizzlepop/screens/zizzlepop/modes/quiz_mode/quiz_screen.dart';
import 'package:zizzlepop/utils/constants.dart';

class QuizHome extends StatelessWidget {
  final List<String> categories = const [
    'Mathematics',
    'Science',
    'Business',
    'History',
    'Geography',
    'Tricky'
  ];

  final Map<String, IconData> categoryIcons = const {
    'Mathematics': Icons.calculate,
    'Science': Icons.science,
    'Business': Icons.business_center,
    'History': Icons.history,
    'Geography': Icons.public,
    'Tricky': Icons.psychology,
  };

  const QuizHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Quiz Mode')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            childAspectRatio: 1.2,
          ),
          itemCount: categories.length,
          itemBuilder: (context, index) {
            final category = categories[index];
            return Card(
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ), // Fixed: Added closing parenthesis and comma
              child: InkWell(
                borderRadius: BorderRadius.circular(16),
                onTap: () => _startQuiz(context, category),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(categoryIcons[category], size: 50, color: kPrimaryColor),
                    const SizedBox(height: 10),
                    Text(
                      category,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ); // Fixed: Added closing parenthesis
          },
        ),
      ),
    );
  }

  void _startQuiz(BuildContext context, String category) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => QuizScreen(category: category),
      ),
    );
  }
}