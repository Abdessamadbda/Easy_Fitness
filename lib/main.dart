import 'package:easy_fitness/datamanager.dart';
import 'package:easy_fitness/pages/equipmentpage.dart';
import 'package:easy_fitness/pages/musclepage.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Easy Fitness',
      theme: ThemeData(
        
        colorScheme: ColorScheme.fromSeed(seedColor: Color.fromARGB(255, 102, 107, 107)),
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
          currentWidgetPage =   MusclePage(dataManager: dataManager,);
          break;
          case 1:
          currentWidgetPage =   EquipmentPage(dataManager: dataManager,);
          break;
          case 2:
          currentWidgetPage = const Text("Exercices by equipment");
          break;
         
      }
      return Scaffold(
      appBar: AppBar(
            backgroundColor: Theme.of(context).colorScheme.inversePrimary,
         title: Image.asset("images/logo.png"),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: selectedIndex,
        onTap: (newIndex) {
          setState(() {
            selectedIndex = newIndex;
          });
        },
        backgroundColor: Theme.of(context).secondaryHeaderColor,
        selectedItemColor: Theme.of(context).primaryColor,
        unselectedItemColor: const Color.fromARGB(255, 0, 0, 0),
        items: const [
        BottomNavigationBarItem(label: "By Muscle", icon: Icon(Icons.monitor_heart,),),
        BottomNavigationBarItem(label: "By equipment", icon: Icon(Icons.fitness_center,),),
        BottomNavigationBarItem(label: "Favorite", icon: Icon(Icons.favorite,),),


        


      ]),
      body: 
        currentWidgetPage,
    );
  }
}
