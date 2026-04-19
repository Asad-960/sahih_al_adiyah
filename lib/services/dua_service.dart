import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/dua.dart';

final duaServiceProvider = Provider<DuaService>((ref) => DuaService());

class DuaService {
  Future<List<Dua>> fetchDuas() async {
    try {
      // Load the JSON string from assets
      final String jsonString = await rootBundle.loadString(
        'assets/data/duas.json',
      );

      // Decode the JSON string
      final Map<String, dynamic> jsonData = jsonDecode(jsonString);
      final List<dynamic> duasList = jsonData['duas'];

      // Map it to our Dua model
      return duasList.map((json) => Dua.fromJson(json)).toList();
    } catch (e) {
      throw Exception('Failed to load duas from JSON: $e');
    }
  }
}
