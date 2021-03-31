import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../style.dart';
import 'ScreenBuildingConstructionGame.dart';
import 'ScreenBuildingConstructionStage.dart';

class ScreenBuildingConstructionLevel extends StatelessWidget {
  String difficulty;
  final int numberOfLevel = 5;

  ScreenBuildingConstructionLevel(String diff) {
    difficulty = diff;
    print(difficulty);
  }

  @override
  Widget build(BuildContext context) {
    return Stack (
      children : [
        Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/images/backgrounds/city3.png"),
                    fit: BoxFit.cover)
            ),
            alignment: Alignment.center,
            child: Column(
                children: [
                  Align(
                    alignment: Alignment.centerRight,
                    child: Padding(
                        padding: EdgeInsets.all(5.0),
                        child: ElevatedButton(
                          child: Text('Return',style: TextStyle(color:Colors.white)),
                          style: Style.returnButtonText,
                          onPressed: () {
                            Navigator.of(context).push( //Navigateur vers widget
                              MaterialPageRoute(builder: (context)=>
                                  ScreenBuildingConstructionStage(),
                              ),
                            );
                          },
                        )
                    ),
                  ),
                  Text('Choose a level', style: TextStyle(
                      fontSize: 18,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      decoration: TextDecoration.none),
                  ),
                  Expanded(
                      child: GridView.count(
                          padding: const EdgeInsets.all(30),
                          crossAxisSpacing: 20,
                          mainAxisSpacing: 20,
                          // Create a grid with 8 columns. If you change the scrollDirection to
                          // horizontal, this produces 8 rows.
                          crossAxisCount: 6,
                          // Generate nombreNiveau widgets that display their index in the List.
                          children: List.generate(numberOfLevel, (index) {
                            return ElevatedButton(
                              child: Text('${index+1}'),
                              style: Style.buttonText,
                              onPressed: () {
                                Navigator.of(context).push( //Navigateur vers widget
                                  MaterialPageRoute(builder: (context)=>
                                      ScreenBuildingConstructionGame(difficulty, index+1),
                                  ),
                                );
                                print("Start Game ${index+1} pressed");
                              },
                            );
                          })
                      )
                  )
                ]
            )
        ),
        Positioned(
            top: 0.0,
            left: 0.0,
            child: Row(
              children: [
                Material(
                  color : Colors.transparent,
                  child: Ink(
                      decoration: const ShapeDecoration(
                          color: Colors.transparent,
                          shape: CircleBorder()),
                      child : IconButton(
                        icon: Image.asset('assets/images/icon/uk.png'),
                        onPressed: () {},
                      )
                  ),
                ),
                Material(
                  color : Colors.transparent,
                  child: Ink(
                      decoration: const ShapeDecoration(
                          color: Colors.transparent,
                          shape: CircleBorder()),
                      child : IconButton(
                        icon: Image.asset('assets/images/icon/fr.png'),
                        onPressed: () {},
                      )
                  ),
                ),
                Material(
                  color : Colors.transparent,
                  child: Ink(
                      decoration: const ShapeDecoration(
                          color: Colors.transparent,
                          shape: CircleBorder()),
                      child : IconButton(
                        icon: Image.asset('assets/images/icon/manual.png'),
                        onPressed: () {},
                      )
                  ),
                )
              ],
            )
        )
      ]

    );
  }
}
