import 'package:easy_fitness/datamanager.dart';
import 'package:easy_fitness/datamodel.dart';
import 'package:easy_fitness/pages/EquipmentDetail.dart';
import 'package:easy_fitness/pages/favoritepage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EquipmentPage extends StatelessWidget {
  final DataManager dataManager;
  const EquipmentPage({Key? key, required this.dataManager}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Exercises By Equipment',
            style: TextStyle(
              fontFamily: 'FiraSansItalic',
              color: Color.fromARGB(255, 25, 42, 85),
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: FutureBuilder<List<Category>>(
            future: dataManager.getMenu(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(
                    itemCount: 1,
                    itemBuilder: (context, index) {
                      index = 1;
                      // EACH CATEGORY STARTS HERE
                      var category = snapshot.data![index];
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                                top: 0.0, bottom: 8.0, left: 8.0),
                          ),
                          if (screenSize.width < 500)
                            // EACH MENU ITEM, Mobile Viewport
                            ListView.builder(
                              shrinkWrap: true,
                              physics: ClampingScrollPhysics(),
                              itemCount: category.exercices.length,
                              itemBuilder: (context, index) {
                                return ExerciseItem(
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
                                      child: ExerciseItem(
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
        ));
  }
}

class ExerciseItem extends StatefulWidget {
  final Exercice exercice;
  const ExerciseItem({Key? key, required this.exercice}) : super(key: key);
  @override
  State<ExerciseItem> createState() => _ExerciseItemState();
}

class _ExerciseItemState extends State<ExerciseItem> {
  @override
  void initState() {
    super.initState();

    // Fetch the initial favorite status when the widget is created
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(4.0),
      child: Card(
        elevation: 4,
        color: Colors.yellow.shade100,
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
                              EquipmentDetail(exercise: widget.exercice),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      primary: const Color.fromARGB(
                          255, 25, 42, 85), // Background color
                      onPrimary: const Color.fromARGB(
                          255, 255, 255, 255), // Text color
                      padding: EdgeInsets.symmetric(
                          horizontal: 16, vertical: 8), // Padding
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(8.0), // Border radius
                      ),
                    ),
                    child: const Text(
                      "Detail",
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
