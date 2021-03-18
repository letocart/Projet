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
    return Container(
      // Background
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/images/backgrounds/city2.jpg"),
              fit: BoxFit.cover)
      ),
      alignment: Alignment.center,
      // Column to have each items on top of each others
      child: Column(
        children: [
          // First child : return button
          Align(
            alignment: Alignment.centerRight,
            child: Padding(
                padding: EdgeInsets.all(5.0),
                child: ElevatedButton(
                  child: Text('Return',style: TextStyle(color:Colors.white)),
                  style: Style.returnButtonText,
                  onPressed: () {
                    // Return to difficulty selection screen
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (context)=>
                          ScreenBuildingConstructionStage(),
                      ),
                    );
                  },
                )
            ),
          ),
          // Second child : title text
          Text('Choose a level', style: TextStyle(
              fontSize: 18,
              color: Colors.black,
              fontWeight: FontWeight.bold,
              decoration: TextDecoration.none),
          ),
          // Third child : grid of button to choose a level
          Expanded(
            // Scrollable grid of item
            child: GridView.count(
              padding: const EdgeInsets.all(30),
              crossAxisSpacing: 20,
              mainAxisSpacing: 20,
              // Create a grid with 6 columns
              crossAxisCount: 6,
              // Generate numberOfLevel buttons that display their index in the List.
              children: List.generate(numberOfLevel, (index) {
                return ElevatedButton(
                  child: Text('${index+1}'),
                  style: Style.buttonText,
                  onPressed: () {
                    // Go to the selected level
                    Navigator.of(context).push(
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
    );
  }
}
