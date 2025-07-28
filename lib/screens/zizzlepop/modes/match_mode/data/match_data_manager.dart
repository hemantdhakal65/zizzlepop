import 'dart:convert';
import 'package:flutter/services.dart';

class MatchDataManager {
  static Future<List<Map<String, dynamic>>> getItems({
    required String category,
  }) async {
    final String filePath = 'assets/data/match_mode/categories/${category}_sounds.json';

    try {
      final data = await rootBundle.loadString(filePath);
      final List<dynamic> jsonList = json.decode(data);
      return jsonList.cast<Map<String, dynamic>>();
    } catch (e) {
      print('Error loading $filePath: $e');
      return [];
    }
  }
}