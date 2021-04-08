import 'dart:convert';

import 'package:collection/collection.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:or_game_app_v4/BuildingConstruction/controller/BuildingsConstructionController.dart';
import 'package:or_game_app_v4/BuildingConstruction/data/BuildingConstructionData.dart';
import 'package:or_game_app_v4/view/IconWidget.dart';

import '../../StorageUtil.dart';
import '../../style.dart';
import 'ScreenBuildingConstructionGame.dart';
import 'ScreenBuildingConstructionStage.dart';

//stateful widget
class ScreenBuildingConstructionLevel extends StatefulWidget {
  List dataInstances;
  int difficultyIndex;

  ScreenBuildingConstructionLevel(this.dataInstances,this.difficultyIndex);

  // overriding the createState method
  @override
  State<StatefulWidget> createState() => ScreenBuildingConstructionLevelState(this.dataInstances,this.difficultyIndex);
}

//the state
class ScreenBuildingConstructionLevelState extends State<ScreenBuildingConstructionLevel> {
  List dataInstances;
  int difficultyIndex;
  int numberOfLevels=0;
  ScreenBuildingConstructionLevelState(this.dataInstances,this.difficultyIndex);

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    this.numberOfLevels = this.dataInstances[this.difficultyIndex]["instances"].length;
    return Column(
        children : [
          Container(
            height: MediaQuery.of(context).padding.top,
            width : MediaQuery.of(context).size.width,
            color : Colors.black
          ),
          Container(
            height: MediaQuery.of(context).size.height -  MediaQuery.of(context).padding.top,
            width : MediaQuery.of(context).size.width,
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
                      child: GridView.count(
                        padding: const EdgeInsets.all(30),
                        crossAxisSpacing: 20,
                        mainAxisSpacing: 20,
                        // Create a grid with 8 columns. If you change the scrollDirection to
                        // horizontal, this produces 8 rows.
                        crossAxisCount: 6,
                        // Generate nombreNiveau widgets that display their index in the List.
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
                              Navigator.of(context).push( //Navigateur vers widget
                                MaterialPageRoute(builder: (context)=>
                                //ScreenBuildingConstructionGame(difficulty, index+1),
                                ScreenBuildingConstructionGame(this.dataInstances, this.difficultyIndex, levelIndex,
                                    BuildingConstructionController.fromBCD(
                                        BuildingConstructionData(solutionValue, numberOfBuildings, maxHeight, pricesOfFloors, earningsFromClients, requestsOfFloorsFromClients)
                                    ),
                                )
                                ),
                              );
                              //print("Start Game ${index+1} pressed");
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