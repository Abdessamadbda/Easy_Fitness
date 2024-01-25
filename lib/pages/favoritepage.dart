import 'package:easy_fitness/datamodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FavoritePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Access the FavoriteExercisesNotifier from the provider
    final favoriteExercisesNotifier =
        Provider.of<FavoriteExercisesNotifier>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Favorite Images'),
      ),
      body: ListView.builder(
        itemCount: favoriteExercisesNotifier.favoriteImages.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(20.0),
            child: Card(
              elevation: 4.0, // You can adjust the elevation as needed
              child: Stack(
                children: [
                  // Image in the center
                  Image.network(
                    favoriteExercisesNotifier.favoriteImages[index],
                    fit: BoxFit.fill,
                    width: double.infinity,
                    height: 200.0, // Adjust the height as needed
                  ),
                  // Label in the top right corner
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
                            ._favoriteExercises[index].name,
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
      ),
    );
  }
}

class FavoriteExercisesNotifier extends ChangeNotifier {
  List<String> _favoriteImages = [];
  List<Exercice> _favoriteExercises = [];

  List<String> get favoriteImages => _favoriteImages;

  void toggleFavoriteImage(String imageUrl, Exercice exercice) {
    if (_favoriteImages.contains(imageUrl)) {
      removeFavoriteImage(imageUrl);
      _favoriteExercises.remove(exercice);
    } else {
      addFavoriteImage(imageUrl);
      _favoriteExercises.add(exercice);
    }
  }

  void addFavoriteImage(String imageUrl) {
    _favoriteImages.add(imageUrl);
    notifyListeners();
  }

  void removeFavoriteImage(String imageUrl) {
    _favoriteImages.remove(imageUrl);
    notifyListeners();
  }
}
