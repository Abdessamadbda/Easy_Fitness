import 'package:easy_fitness/datamanager.dart';
import 'package:easy_fitness/pages/MuscleDetail.dart';
import 'package:easy_fitness/pages/favoritepage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../datamodel.dart';
import '../datamanager.dart';

class MusclePage extends StatelessWidget {
  final DataManager dataManager;

  const MusclePage({Key? key, required this.dataManager}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: FutureBuilder<List<Category>>(
        future: dataManager.getMenu(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
                itemCount: 1,
                itemBuilder: (context, index) {
                  index = 0;
                  // EACH CATEGORY STARTS HERE
                  var category = snapshot.data![index];
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 32.0, bottom: 8.0, left: 8.0),
                        child: Text(
                          "Exercises By Muscle : ",
                          style: TextStyle(color: Colors.brown.shade400),
                        ),
                      ),
                      if (screenSize.width < 500)
                        // EACH MENU ITEM, Mobile Viewport
                        ListView.builder(
                          shrinkWrap: true,
                          physics: ClampingScrollPhysics(),
                          itemCount: category.exercices.length,
                          itemBuilder: (context, index) {
                            return ExerciceItem(
                              exercice: category.exercices[index],
                            );
                          },
                        )
                      else
                        // EACH MENU ITEM, Large Viewport
                        Center(
                          child: Wrap(
                            alignment: WrapAlignment.spaceAround,
                            children: [
                              for (var exercice in category.exercices)
                                SizedBox(
                                  width: 350,
                                  child: ExerciceItem(
                                    exercice: exercice,
                                  ),
                                )
                            ],
                          ),
                        )
                    ],
                  );
                });
          } else if (snapshot.hasError) {
            return Text('${snapshot.error}');
          }
          // By default, show a loading spinner.
          return const CircularProgressIndicator();
        },
      ),
    );
  }
}

class ExerciceItem extends StatefulWidget {
  final Exercice exercice;
  const ExerciceItem({Key? key, required this.exercice}) : super(key: key);
  @override
  State<ExerciceItem> createState() => _ExerciceItemState();
}

class _ExerciceItemState extends State<ExerciceItem> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(4.0),
      child: Card(
        elevation: 4,
        child: Column(
          children: [
            Stack(
              children: [
                Image.network(widget.exercice.imageUrl),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SelectableText(
                        widget.exercice.name,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                MuscleDetail(exercise: widget.exercice),
                          ),
                        );
                      },
                      child: const Text("Detail"))
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
