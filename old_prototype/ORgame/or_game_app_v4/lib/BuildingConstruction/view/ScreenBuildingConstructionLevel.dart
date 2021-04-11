import 'dart:convert';
import 'package:collection/collection.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:or_game_app_v4/BuildingConstruction/controller/BuildingsConstructionController.dart';
import 'package:or_game_app_v4/BuildingConstruction/data/BuildingConstructionData.dart';
import 'package:or_game_app_v4/view/IconWidget.dart';
import 'package:or_game_app_v4/view/StatusBar.dart';

import '../../StorageUtil.dart';
import '../../style.dart';
import 'ScreenBuildingConstructionGame.dart';
import 'ScreenBuildingConstructionStage.dart';


// The Screen Building Construction Level Class
class ScreenBuildingConstructionLevel extends StatefulWidget {

  // Data instances list in order to render the right informations from the database
  List dataInstances;

  // a reference to the difficulty which the levels belongs to
  int difficultyIndex;

  // Constructor
  ScreenBuildingConstructionLevel(this.dataInstances,this.difficultyIndex);

  // overriding the createState method
  @override
  State<StatefulWidget> createState() => ScreenBuildingConstructionLevelState(this.dataInstances,this.difficultyIndex);
}

//the Screen Building Construction Level State
class ScreenBuildingConstructionLevelState extends State<ScreenBuildingConstructionLevel> {
  List dataInstances;
  int difficultyIndex;
  int numberOfLevels=0;

  // Constructor
  ScreenBuildingConstructionLevelState(this.dataInstances,this.difficultyIndex);

  // Initiating state
  @override
  void initState() {
    super.initState();
  }

  // Building UI
  @override
  Widget build(BuildContext context) {
    // get number of levels from dataInstance using difficultyIndex
    this.numberOfLevels = this.dataInstances[this.difficultyIndex]["instances"].length;
    return Column(
        children : [
          // StatusBar
          StatusBar(),
          // Main container with a background
          Container(
            height: MediaQuery.of(context).size.height -  MediaQuery.of(context).padding.top, // height of the screen minus the height of the status bar
            width : MediaQuery.of(context).size.width, // Width of the screen
              // Decoration to add a background
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/images/backgrounds/city3.png"),
                    fit: BoxFit.cover)
            ),
            alignment: Alignment.center,
            child : Stack (
              children : [
                Column(
                  children: [
                    // Return to previous screen button at the top right of the screen
                    Align(
                      alignment: Alignment.centerRight,
                      child: Padding(
                          padding: EdgeInsets.all(5.0),
                          child: ElevatedButton(
                            child: Text(getText('returnButtonText'),style: TextStyle(color:Colors.white)),
                            style: Style.returnButtonText,
                            onPressed: () {
                              Navigator.of(context).push( //Navigateur vers widget
                                MaterialPageRoute(builder: (context)=>
                                    ScreenBuildingConstructionStage(this.dataInstances),
                                ),
                              );
                            },
                          )
                      ),
                    ),
                    Stack(
                      children: [
                        // Choose Level Title
                        // Styling the title with a shadow text
                        Text(getText('chooseLevelText'),style : TextStyle(
                            fontSize: 18,
                            foreground: Paint()
                              ..style = PaintingStyle.stroke
                              ..strokeWidth = 2.5
                              ..color = Colors.white,
                            fontWeight: FontWeight.bold, decoration: TextDecoration.none),
                        ),
                        Text(getText('chooseLevelText'), style: TextStyle(
                            fontSize: 18,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            decoration: TextDecoration.none),
                        )
                      ],
                    ),
                    Expanded(
                      // Create a grid with 8 columns. If you change the scrollDirection to
                      // horizontal, this produces 8 rows.
                      child: GridView.count(
                        padding: const EdgeInsets.all(30),
                        crossAxisSpacing: 20,
                        mainAxisSpacing: 20,
                        crossAxisCount: 6,
                        // Generate numberOfLevels widgets that display their indexes in the List.
                        children:
                        List.generate(numberOfLevels, (levelIndex) {
                          return ElevatedButton(
                            child: Text('${levelIndex+1}'),
                            style: Style.buttonText,
                            onPressed: () {
                              List<double> pricesOfFloors = [];
                              List<double> earningsFromClients = [];
                              List<int> requestsOfFloorsFromClients = [];
                              double solutionValue = 0;
                              int numberOfBuildings = 0;
                              int maxHeight = 0;
                              // In function of the player's choice, an instance is retrieved from the database and rendered afterward in the game view
                              // These lines of code get all the information related to the instance
                              if(!ListEquality().equals(dataInstances, [])) {
                                solutionValue = dataInstances[this.difficultyIndex]["instances"][levelIndex]["solutionValue"];
                                numberOfBuildings = dataInstances[this.difficultyIndex]["instances"][levelIndex]["numberOfBuildings"];
                                maxHeight = dataInstances[this.difficultyIndex]["instances"][levelIndex]["maxHeight"];

                                for(int i=0;i<dataInstances[this.difficultyIndex]["instances"][levelIndex]['pricesOfFloors'].length;i++)
                                  pricesOfFloors.add(dataInstances[this.difficultyIndex]["instances"][levelIndex]['pricesOfFloors'][i].toDouble());

                                for(int i=0;i<dataInstances[this.difficultyIndex]["instances"][levelIndex]['earningsFromClients'].length;i++)
                                  earningsFromClients.add(dataInstances[this.difficultyIndex]["instances"][levelIndex]['earningsFromClients'][i].toDouble());

                                for(int i=0;i<dataInstances[this.difficultyIndex]["instances"][levelIndex]['requestsOfFloorsFromClients'].length;i++)
                                  requestsOfFloorsFromClients.add(dataInstances[this.difficultyIndex]["instances"][levelIndex]['requestsOfFloorsFromClients'][i]);
                              }
                              Navigator.of(context).push( // Navigator to widget
                                // Redirecting to the Screen Building Construction Game view after choosing a level
                                MaterialPageRoute(builder: (context)=>
                                //ScreenBuildingConstructionGame(difficulty, index+1),
                                ScreenBuildingConstructionGame(this.dataInstances, this.difficultyIndex, levelIndex,
                                    BuildingConstructionController.fromBCD(
                                        BuildingConstructionData(solutionValue, numberOfBuildings, maxHeight, pricesOfFloors, earningsFromClients, requestsOfFloorsFromClients)
                                    ),
                                )
                                ),
                              );
                            },
                          );
                        })
                      )
                    )
                  ]
                ),
                IconWidget(Axis.horizontal,this)
              ]
            )
          )
        ]
    );
  }
}