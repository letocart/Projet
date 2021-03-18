import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:or_game_app_v4/view/ScreenMainMenu.dart';

import '../../style.dart';
import 'ScreenBuildingConstructionLevel.dart';

class ScreenBuildingConstructionStage extends StatelessWidget {
  // List of difficulty to create a list of button
  final List<String> entries = <String>['Tutorial', 'Easy', 'Normal', 'Hard', 'Insane'];

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
                child: Text('Return'),
                style: Style.returnButtonText,
                onPressed: () {
                  // Return to main menu
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (context)=>
                        ScreenMenuPrincipal(),
                    ),
                  );
                },
              )
            ),
          ),
          // Second child : title text
          Text(
            'Choose a difficulty',
            style : TextStyle(fontSize: 18, color: Colors.black, fontWeight: FontWeight.bold, decoration: TextDecoration.none),
          ),
          // Third child : list of button to choose a difficulty
          Expanded(
            // Scrollable list of separated items
            child: ListView.separated(
              padding: const EdgeInsets.all(8),
              // Create a button for each difficulty
              itemCount: entries.length,
              itemBuilder: (BuildContext context, int index) {
                return ElevatedButton(
                  child: Text('${entries[index]}'),
                  style: Style.buttonText,
                  onPressed: () {
                    // Go to the level selection screen for the selected difficulty
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (context)=>
                          ScreenBuildingConstructionLevel(entries[index]),
                      ),
                    );
                    print("Start Game ${entries[index]} pressed");
                  },
                );
              },
              // Create a separator
              separatorBuilder: (BuildContext context, int index) => const Divider(),
            )
          )
      ])
    );
  }
}
