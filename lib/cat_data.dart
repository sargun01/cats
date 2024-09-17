import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import 'cat_breed.dart';

class CatData {
  static Future<List<CatBreed>> loadCatBreeds() async {
    final jsonString = await rootBundle.loadString('assets/cat_breeds.json');
    final List<dynamic> jsonList = json.decode(jsonString);
    return jsonList.map((json) => CatBreed.fromJson(json)).toList();
  }
}
