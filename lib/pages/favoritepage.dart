import 'package:easy_fitness/datamodel.dart';
import 'package:easy_fitness/pages/equipmentpage.dart';
import 'package:easy_fitness/pages/musclepage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FavoritePage extends StatelessWidget {
  const FavoritePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var favoriteExercises =
        Provider.of<FavoriteExercisesNotifier>(context).favoriteExercises;

    return Scaffold(
      appBar: AppBar(
        title: Text('Favorite Exercises'),
      ),
      body: favoriteExercises.isEmpty
          ? Center(
              child: Text('No favorite exercises yet.'),
            )
          : ListView.builder(
              shrinkWrap: true,
              physics: ClampingScrollPhysics(),
              itemCount: favoriteExercises.length,
              itemBuilder: (context, index) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                          top: 8.0, bottom: 8.0, left: 68.0, right: 68.0),
                      child: ExerciceItem(
                        exercice: favoriteExercises[index],
                        showFavoriteIcon: false,
                      ),
                    ),
                  ],
                );
              },
            ),
    );
  }
}

class FavoriteExercisesNotifier extends ChangeNotifier {
  List<Exercice> _favoriteExercises = [];

  List<Exercice> get favoriteExercises => _favoriteExercises;

  void toggleFavorite(Exercice exercice) {
    if (_favoriteExercises.contains(exercice)) {
      _favoriteExercises.remove(exercice);
    } else {
      _favoriteExercises.add(exercice);
    }
    notifyListeners();
  }
}
