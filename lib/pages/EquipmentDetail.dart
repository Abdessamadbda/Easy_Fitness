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
  final CarouselController _carouselController = CarouselController();
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    var isFavoriteImageList = Provider.of<FavoriteExercisesNotifier>(context)
        .favoriteItems
        .map((item) => item.imageUrl)
        .toList();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.exercise.name),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 40.0),
            child: Stack(
              children: [
                CarouselSlider(
                  carouselController: _carouselController,
                  options: CarouselOptions(
                    enlargeCenterPage: true,
                    autoPlay: true,
                    aspectRatio: 19 / 9,
                    onPageChanged: (index, reason) {
                      setState(() {
                        _currentIndex = index;
                      });
                    },
                  ),
                  items: widget.exercise.photos.asMap().entries.map((entry) {
                    final int index = entry.key;
                    final bool isFavorite = isFavoriteImageList
                        .contains(widget.exercise.getPhotoUrlByIndex(index));

                    return Builder(
                      builder: (BuildContext context) {
                        return GestureDetector(
                          onTap: () {
                            Provider.of<FavoriteExercisesNotifier>(context,
                                    listen: false)
                                .toggleFavoriteImage(
                                    widget.exercise.getPhotoUrlByIndex(index),
                                    widget.exercise);
                          },
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12.0),
                              border: Border.all(
                                color: Theme.of(context)
                                    .colorScheme
                                    .inversePrimary,
                                width: 2.0,
                              ),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10.0),
                              child: Stack(
                                alignment: Alignment.topRight,
                                children: [
                                  Image.network(
                                    widget.exercise.getPhotoUrlByIndex(index),
                                    fit: BoxFit.fill,
                                    height: double.infinity,
                                    width: double.infinity,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Icon(
                                      isFavorite
                                          ? Icons.favorite
                                          : Icons.favorite_border,
                                      color: Colors.red,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  }).toList(),
                ),
                Positioned(
                  bottom: 10.0,
                  left: 0,
                  right: 0,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      widget.exercise.photos.length,
                      (index) => buildDot(index),
                    ),
                  ),
                ),
              ],
            ),
          ),
          // Other details about the exercise
          // ... add other details here
        ],
      ),
    );
  }

  Widget buildDot(int index) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 4.0),
      width: 10.0,
      height: 10.0,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: _currentIndex == index ? Colors.blue : Colors.grey,
      ),
    );
  }
}
