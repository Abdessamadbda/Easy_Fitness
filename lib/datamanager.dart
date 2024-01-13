import 'dart:convert';

import 'datamodel.dart';
import 'package:http/http.dart' as http;

class DataManager {
  List<Category>? _category;
  List<ItemInCart> cart = [];

  fetchMenu() async {
    try {
      const url = 'https://abdessamadbda.github.io/easyfitness_api/exercises.json';
      var response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        _category = [];
        var decodedData = jsonDecode(response.body) as List<dynamic>;
        for (var json in decodedData) {
          _category?.add(Category.fromJson(json));
        }
      } else {
        throw Exception("Error loading data");
      }
    } catch (e) {
      throw Exception("Error loading data");
    }
  }

    Future<List<Category>> getMenu() async {
    if (_category == null) {
      await fetchMenu();
    }
    return _category!;
  }

}