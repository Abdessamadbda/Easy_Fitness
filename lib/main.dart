import 'package:easy_fitness/datamanager.dart';
import 'package:easy_fitness/pages/equipmentpage.dart';
import 'package:easy_fitness/pages/favoritepage.dart';
import 'package:easy_fitness/pages/musclepage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  FavoriteExercisesNotifier favoriteExercisesNotifier =
      FavoriteExercisesNotifier();
  await favoriteExercisesNotifier.loadFavorites();

  runApp(
    ChangeNotifierProvider(
      create: (context) => favoriteExercisesNotifier,
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Easy Fitness',
      theme: ThemeData(
        colorScheme:
            ColorScheme.fromSeed(seedColor: Color.fromARGB(255, 102, 107, 107)),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var dataManager = DataManager();
  var selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    Widget currentWidgetPage = const Text("!!!!");
    switch (selectedIndex) {
      case 0:
        currentWidgetPage = MusclePage(
          dataManager: dataManager,
        );
        break;
      case 1:
        currentWidgetPage = EquipmentPage(
          dataManager: dataManager,
        );
        break;
      case 2:
        currentWidgetPage = FavoritePage(
          favoriteExercisesNotifier:
              Provider.of<FavoriteExercisesNotifier>(context),
        );
        break;
    }
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 240, 228, 63),
        title: Image.asset(
          "images/logo.png",
          height: 120,
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: selectedIndex,
          onTap: (newIndex) {
            setState(() {
              selectedIndex = newIndex;
            });
          },
          backgroundColor: Colors.yellow.shade100,
          selectedItemColor: Color.fromARGB(255, 25, 42, 85),
          unselectedItemColor: Color.fromARGB(255, 143, 140, 140),
          items: const [
            BottomNavigationBarItem(
              label: "By Muscle",
              icon: Icon(
                Icons.monitor_heart,
              ),
            ),
            BottomNavigationBarItem(
              label: "By equipment",
              icon: Icon(
                Icons.fitness_center,
              ),
            ),
            BottomNavigationBarItem(
              label: "Favorite",
              icon: Icon(
                Icons.favorite,
              ),
            ),
          ]),
      body: currentWidgetPage,
    );
  }
}
