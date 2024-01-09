import 'package:flutter/material.dart';

class ExercicesPage extends StatelessWidget {
  const ExercicesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: const [
        Exercice(
          title:"SHOULDERS"),
          Exercice(
          title:"SHOULDERS"),
          Exercice(
          title:"SHOULDERS"),
          Exercice(
          title:"SHOULDERS"),
          Exercice(
          title:"SHOULDERS"),
          Exercice(
          title:"SHOULDERS"),
      ],
      
    );
  }
}

class Exercice extends StatelessWidget {
  final String title;
  const Exercice({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height:150,
      child:
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: 
            Card(
              color: Colors.grey,
              elevation: 7,
              child: 
                Container(
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      fit:BoxFit.cover,
                      image: AssetImage(
                      "images/background.png",
                    )
                    ),
                  ),
                  child: 
                    Column(
                      children: [
                        Center(
                          child: 
                          Container(
                            color: const Color.fromARGB(255, 226, 225, 221),
                            child: 
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: 
                                  Text(
                                  title,
                                  style: Theme.of(context).textTheme.headline5),
                                
                              ),
                            
                          ))
                      ]
                    ),
                  
                ),
            ),
          
        ),
    );
  }
}