import 'dart:convert';
import 'dart:math';
import 'package:flutter/services.dart';

class QuizDataManager {
  static final Map<String, List<String>> _categoryFiles = {
    'Mathematics': ['algebra', 'geometry', 'calculus', 'statistics'],
    'Science': ['physics', 'chemistry', 'biology', 'astronomy'],
    'Business': ['economics', 'finance', 'marketing', 'management'],
    'History': ['ancient', 'medieval', 'modern', 'world_wars'],
    'Geography': ['countries', 'capitals', 'landmarks', 'earth_science'],
    'Tricky': ['riddles', 'logic_puzzles', 'lateral_thinking', 'brain_teasers'],
  };

  static final Map<String, List<Map<String, dynamic>>> _memoryCache = {};
  static final Map<String, Set<int>> _usedIndices = {};
  static final Random _random = Random();

  static Future<List<Map<String, dynamic>>> getQuestions({
    required String category,
    int count = 10,
    String difficulty = 'medium',
  }) async {
    final List<Map<String, dynamic>> questions = [];
    final subcategories = _categoryFiles[category] ?? [];

    // Shuffle subcategories to distribute load
    subcategories.shuffle();

    for (final subcategory in subcategories) {
      if (questions.length >= count) break;

      final String filePath =
          'assets/data/quiz_mode/${category.toLowerCase()}/$subcategory.json';

      try {
        // Load from cache or file
        List<Map<String, dynamic>>? subcatQuestions = _memoryCache[filePath];

        if (subcatQuestions == null) {
          final data = await rootBundle.loadString(filePath);
          final List<dynamic> jsonList = json.decode(data);
          subcatQuestions = jsonList.cast<Map<String, dynamic>>();
          // FIX: Removed unnecessary non-null assertion (!)
          _memoryCache[filePath] = subcatQuestions;
        }

        // Filter by difficulty
        final filtered = subcatQuestions
            .where((q) => q['difficulty'] == difficulty)
            .toList();

        // Get unused questions
        final availableIndices = List.generate(filtered.length, (index) => index)
            .where((idx) => !_usedIndices.containsKey(filePath) ||
            !_usedIndices[filePath]!.contains(idx))
            .toList();

        if (availableIndices.isEmpty) continue;

        // Select random questions
        final needed = count - questions.length;
        final takeCount = min(needed, availableIndices.length);
        final selectedIndices = _getRandomIndices(availableIndices, takeCount);

        for (final idx in selectedIndices) {
          questions.add(filtered[idx]);
          _usedIndices[filePath] ??= {};
          _usedIndices[filePath]!.add(idx);
        }
      } catch (e) {
        print('Error loading $filePath: $e');
      }
    }

    // Shuffle final questions
    questions.shuffle();
    return questions;
  }

  static List<int> _getRandomIndices(List<int> indices, int count) {
    if (count >= indices.length) return indices;
    final selected = <int>{};
    while (selected.length < count) {
      selected.add(indices[_random.nextInt(indices.length)]);
    }
    return selected.toList();
  }

  static void resetCache() {
    _memoryCache.clear();
    _usedIndices.clear();
  }
}