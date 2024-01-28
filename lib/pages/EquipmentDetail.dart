import 'package:carousel_slider/carousel_slider.dart';
import 'package:easy_fitness/datamodel.dart';
import 'package:easy_fitness/pages/favoritepage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EquipmentDetail extends StatefulWidget {
  final Exercice exercise;

  const EquipmentDetail({Key? key, required this.exercise}) : super(key: key);

  @override
  _EquipmentDetailState createState() => _EquipmentDetailState();
}

class _EquipmentDetailState extends State<EquipmentDetail> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.exercise.name),
      ),
      body: Column(
        //mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 40.0),
            child: Consumer<FavoriteExercisesNotifier>(
              builder: (context, favoriteExercisesNotifier, child) {
                var isFavoriteImageList = favoriteExercisesNotifier
                    .favoriteItems
                    .map((item) => item.imageUrl)
                    .toList();

                return Column(
                  children: [
                    GestureDetector(
                      onTap: () {
                        favoriteExercisesNotifier.toggleFavoriteImage(
                          widget.exercise.getPhotoUrlByIndex(_currentIndex),
                          widget.exercise,
                        );
                      },
                      child: Container(
                        margin: EdgeInsets.only(top: 70.0),
                        width: MediaQuery.of(context).size.width,
                        height: 200.0,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12.0),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 8,
                              blurRadius: 12,
                              offset: Offset(0, 3),
                            ),
                          ],
                        ),
                        child: Stack(
                          alignment: Alignment.topRight,
                          children: [
                            Image.network(
                              widget.exercise.getPhotoUrlByIndex(_currentIndex),
                              fit: BoxFit.fill,
                              height: double.infinity,
                              width: double.infinity,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      favoriteExercisesNotifier
                                          .toggleFavoriteImage(
                                        widget.exercise
                                            .getPhotoUrlByIndex(_currentIndex),
                                        widget.exercise,
                                      );
                                    },
                                    child: Icon(
                                      isFavoriteImageList.contains(widget
                                              .exercise
                                              .getPhotoUrlByIndex(
                                                  _currentIndex))
                                          ? Icons.favorite
                                          : Icons.favorite_border,
                                      color: Colors.red,
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      showDialog(
                                        context: context,
                                        builder: (context) {
                                          return AlertDialog(
                                            title: Text(widget.exercise
                                                .getExByIndex(_currentIndex)),
                                            content: Text(widget.exercise
                                                .getDetailByIndex(
                                                    _currentIndex)),
                                            actions: [
                                              TextButton(
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                },
                                                child: Text("OK"),
                                              ),
                                            ],
                                          );
                                        },
                                      );
                                    },
                                    child: Icon(
                                      Icons.info,
                                      color: Colors.blue,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 45.0), // Increased margin
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(
                        widget.exercise.photos.length,
                        (index) => buildDot(index),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
          // Other details about the exercise
          // ... add other details here
        ],
      ),
    );
  }

  Widget buildDot(int index) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _currentIndex = index;
        });
      },
      child: Opacity(
        opacity: _currentIndex == index ? 1.0 : 0.5,
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 12.0), // Increased margin
          width: 40.0,
          height: 40.0,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: _currentIndex == index ? Colors.blue : Colors.grey,
            image: DecorationImage(
              image: NetworkImage(
                widget.exercise.getPhotoUrlByIndex(index),
              ),
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }
}
