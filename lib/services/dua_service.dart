import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/dua.dart';

final duaServiceProvider = Provider<DuaService>((ref) => DuaService());

// Top-level function for run-in-background via compute
List<Dua> _parseDuasInBackground(String jsonString) {
  final Map<String, dynamic> jsonData = jsonDecode(jsonString);
  final List<dynamic> duasList = jsonData['duas'];
  return duasList.map((json) => Dua.fromJson(json)).toList();
}

class DuaService {
  Future<List<Dua>> fetchDuas() async {
    try {
      // Load the JSON string from assets
      final String jsonString = await rootBundle.loadString(
        'assets/data/duas.json',
      );

      // Decode the JSON string and map to the model on a background isolate
      return await compute(_parseDuasInBackground, jsonString);
    } catch (e) {
      throw Exception('Failed to load duas from JSON: $e');
    }
  }
}
