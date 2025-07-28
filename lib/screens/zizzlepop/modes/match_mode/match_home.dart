import 'package:flutter/material.dart';
import 'package:zizzlepop/screens/zizzlepop/modes/match_mode/match_screen.dart';

class MatchHome extends StatelessWidget {
  final List<Map<String, dynamic>> categories = const [
    {
      'name': 'Emoji Sounds',
      'icon': Icons.emoji_emotions,
      'type': 'emoji',
      'color': Colors.amber
    },
    {
      'name': 'Animal Sounds',
      'icon': Icons.pets,
      'type': 'animal',
      'color': Colors.brown
    },
    {
      'name': 'Guess by Sound',
      'icon': Icons.hearing,
      'type': 'object',
      'color': Colors.blue
    },
  ];

  const MatchHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Match Mode')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            childAspectRatio: 0.9,
          ),
          itemCount: categories.length,
          itemBuilder: (context, index) {
            final category = categories[index];
            return Card(
              elevation: 5,
              color: category['color'],
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: InkWell(
                borderRadius: BorderRadius.circular(16),
                onTap: () => _startMatch(context, category['type']),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(category['icon'], size: 60, color: Colors.white),
                    const SizedBox(height: 15),
                    Text(
                      category['name'],
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  void _startMatch(BuildContext context, String category) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => MatchScreen(category: category),
      ),
    );
  }
}