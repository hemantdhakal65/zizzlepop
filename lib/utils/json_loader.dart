import 'dart:convert';
import 'package:flutter/services.dart';

class JsonLoader {
  static Future<List<Map<String, dynamic>>> loadJson(String path) async {
    try {
      final String data = await rootBundle.loadString(path);
      final List<dynamic> jsonList = json.decode(data);
      return jsonList.cast<Map<String, dynamic>>();
    } catch (e) {
      print('Error loading JSON from $path: $e');
      return [];
    }
  }
}