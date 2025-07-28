import 'package:flutter/material.dart';

class RevealAnimation extends StatelessWidget {
  final AnimationController controller;
  final bool isRevealed;
  final Map<String, dynamic> item;
  final VoidCallback onNext;

  const RevealAnimation({
    super.key,
    required this.controller,
    required this.isRevealed,
    required this.item,
    required this.onNext,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedCrossFade(
      duration: const Duration(milliseconds: 500),
      crossFadeState: isRevealed
          ? CrossFadeState.showSecond
          : CrossFadeState.showFirst,
      firstChild: const SizedBox.shrink(),
      secondChild: Column(
        children: [
          // Funny Answer Text
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: Text(
              item['answer'],
              style: const TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.deepPurple,
              ),
              textAlign: TextAlign.center,
            ),
          ),

          // Funny Description
          Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: Text(
              item['description'],
              style: const TextStyle(fontSize: 18, fontStyle: FontStyle.italic),
              textAlign: TextAlign.center,
            ),
          ),

          // Fun Facts
          if (item['facts'] != null)
            Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: Text(
                'Did you know? ${item['facts']}',
                style: const TextStyle(fontSize: 16),
                textAlign: TextAlign.center,
              ),
            ),

          // Next Button
          ElevatedButton(
            onPressed: onNext,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green,
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
            ),
            child: const Text(
              'Next',
              style: TextStyle(fontSize: 20),
            ),
          ),
        ],
      ),
    );
  }
}