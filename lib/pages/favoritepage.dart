import 'dart:convert';

import 'package:easy_fitness/datamodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FavoritePage extends StatelessWidget {
  final FavoriteExercisesNotifier favoriteExercisesNotifier;

  FavoritePage({required this.favoriteExercisesNotifier});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Favorite Exercises'),
      ),
      body: Consumer<FavoriteExercisesNotifier>(
        builder: (context, favoriteExercisesNotifier, child) {
          return ListView.builder(
            itemCount: favoriteExercisesNotifier.favoriteItems.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.all(20.0),
                child: Card(
                  elevation: 4.0,
                  child: Stack(
                    children: [
                      Image.network(
                        favoriteExercisesNotifier.favoriteItems[index].imageUrl,
                        fit: BoxFit.fill,
                        width: double.infinity,
                        height: 200.0,
                      ),
                      Positioned(
                        top: 8.0,
                        right: 8.0,
                        child: Container(
                          padding: EdgeInsets.all(8.0),
                          decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.7),
                            borderRadius: BorderRadius.circular(4.0),
                          ),
                          child: Text(
                            favoriteExercisesNotifier
                                ._favoriteItems[index].exercice.name,
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class FavoriteExercisesNotifier extends ChangeNotifier {
  List<FavoriteItem> _favoriteItems = [];

  List<FavoriteItem> get favoriteItems => _favoriteItems;
  void copyFrom(FavoriteExercisesNotifier other) {
    _favoriteItems = List.from(other._favoriteItems);
    notifyListeners();
  }

  Future<void> toggleFavoriteImage(String imageUrl, Exercice exercice) async {
    if (_isFavorite(imageUrl, exercice) == true) {
      await removeFavoriteItem(imageUrl, exercice);
    } else {
      await addFavoriteItem(imageUrl, exercice);
    }
  }

  Object _isFavorite(String imageUrl, Exercice exercice) {
    // Check if the item is in the local list
    bool isFavoriteLocal = _favoriteItems
        .any((item) => item.imageUrl == imageUrl && item.exercice == exercice);

    if (isFavoriteLocal) {
      // If it's in the local list, consider it a favorite
      return true;
    } else {
      // If it's not in the local list, check shared preferences
      return _isFavoriteInSharedPreferences(imageUrl, exercice);
    }
  }

  Future<bool> _isFavoriteInSharedPreferences(
      String imageUrl, Exercice exercice) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? serializedItems = prefs.getStringList('favoriteItems');

    if (serializedItems != null) {
      // Deserialize items from shared preferences
      List<FavoriteItem> favoriteItems = serializedItems
          .map((serializedItem) =>
              FavoriteItem.fromJson(jsonDecode(serializedItem)))
          .toList();

      // Check if the item is in the shared preferences list
      return favoriteItems.any(
          (item) => item.imageUrl == imageUrl && item.exercice == exercice);
    } else {
      return false; // If no data found in shared preferences, consider it not a favorite
    }
  }

  Future<void> addFavoriteItem(String imageUrl, Exercice exercice) async {
    _favoriteItems.add(FavoriteItem(imageUrl: imageUrl, exercice: exercice));
    await saveFavorites();
    notifyListeners();
  }

  Future<void> removeFavoriteItem(String imageUrl, Exercice exercice) async {
    _favoriteItems.removeWhere(
        (item) => item.imageUrl == imageUrl && item.exercice == exercice);
    await saveFavorites();
    notifyListeners();
  }

  // Function to save favorites using shared_preferences
  Future<void> saveFavorites() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.reload();
    List<String> serializedItems =
        _favoriteItems.map((item) => jsonEncode(item.toJson())).toList();
    await prefs.setStringList('favoriteItems', serializedItems);
    notifyListeners();
  }

  // Function to load favorites using shared_preferences
  Future<void> loadFavorites() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.reload();
    List<String>? serializedItems = prefs.getStringList('favoriteItems');

    if (serializedItems != null) {
      _favoriteItems = serializedItems
          .map((serializedItem) =>
              FavoriteItem.fromJson(jsonDecode(serializedItem)))
          .toList();
    }

    notifyListeners();
  }
}

class FavoriteItem {
  final String imageUrl;
  final Exercice exercice;

  FavoriteItem({required this.imageUrl, required this.exercice});

  Map<String, dynamic> toJson() {
    return {'imageUrl': imageUrl, 'exercice': exercice.toJson()};
  }

  factory FavoriteItem.fromJson(Map<String, dynamic> json) {
    return FavoriteItem(
      imageUrl: json['imageUrl'],
      exercice: Exercice.fromJson(json['exercice']),
    );
  }
}
