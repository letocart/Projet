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
  String difficulty;

  ScreenBuildingConstructionLevel(String diff) {
    difficulty = diff;
    print(difficulty);
  }

  // overriding the createState method
  @override
  State<StatefulWidget> createState() => ScreenBuildingConstructionLevelState(difficulty);
}

//the state
class ScreenBuildingConstructionLevelState extends State<ScreenBuildingConstructionLevel> {
  List levelsInformation;
  List instancesInformation;
  int numberOfLevels=0;
  String difficulty;
  ScreenBuildingConstructionLevelState(String diff) {
    difficulty = diff;
    print(difficulty);
  }

  //loading Json data
  Future<String> loadJsonData() async {
    var jsonText = await rootBundle.loadString('assets/problemInstances/BuildingConstruction/BuildingConstruction_'+difficulty+'_Levels.json');
    setState(() {
      levelsInformation = json.decode(jsonText);
    });
    return 'success';
  }

  Future<String> loadJsonData2() async {
    print("IAMJSON2"+difficulty);
    List<String> jsonText = [];
    numberOfLevels = levelsInformation==null ? 0 : levelsInformation[0]['numberOfLevels'];
    List l = [];
    for(int i=0;i<numberOfLevels;i++) {
      jsonText.add(await rootBundle.loadString(
          'assets/problemInstances/BuildingConstruction/'
              'BuildingConstruction_' + difficulty + '_'+(i+1).toString()+'.json'));
      l.add(json.decode(jsonText[i]));
    }
    setState(() {
      instancesInformation = l;});
    return 'success';
  }

  @override
  void initState() {
    super.initState();
    this.loadJsonData();
  }

  @override
  Widget build(BuildContext context) {
    numberOfLevels = levelsInformation==null ? 0 : levelsInformation[0]['numberOfLevels'];
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
                                    ScreenBuildingConstructionStage(),
                                ),
                              );
                            },
                          )
                      ),
                    ),
                    Text(getText('chooseLevelText'), style: TextStyle(
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
                        children:
                        List.generate(numberOfLevels, (index) {
                          return ElevatedButton(
                            child: Text('${index+1}'),
                            style: Style.buttonText,
                            onPressed: () async {
                              //log("before : "+dataInstances.toString());
                              await loadJsonData2();
                              //log("after : "+this.dataInstances.toString());
                              List<double> pricesOfFloors = [];
                              List<double> earningsFromClients = [];
                              List<int> requestsOfFloorsFromClients = [];
                              double solutionValue = 0;
                              int numberOfBuildings = 0;
                              int maxHeight = 0;
                              if(!ListEquality().equals(instancesInformation, [])) {
                                solutionValue = instancesInformation[index]["solutionValue"];
                                numberOfBuildings = instancesInformation[index]["numberOfBuildings"];
                                maxHeight = instancesInformation[index]["maxHeight"];

                                for(int i=0;i<instancesInformation[index]['pricesOfFloors'].length;i++)
                                  pricesOfFloors.add(instancesInformation[index]['pricesOfFloors'][i].toDouble());

                                for(int i=0;i<instancesInformation[index]['earningsFromClients'].length;i++)
                                  earningsFromClients.add(instancesInformation[index]['earningsFromClients'][i].toDouble());

                                for(int i=0;i<instancesInformation[index]['requestsOfFloorsFromClients'].length;i++)
                                  requestsOfFloorsFromClients.add(instancesInformation[index]['requestsOfFloorsFromClients'][i]);
                              }
                              Navigator.of(context).push( //Navigateur vers widget
                                MaterialPageRoute(builder: (context)=>
                                //ScreenBuildingConstructionGame(difficulty, index+1),
                                ScreenBuildingConstructionGame(difficulty, index+1,
                                    BuildingConstructionController.fromBCD(
                                        BuildingConstructionData(solutionValue, numberOfBuildings, maxHeight, pricesOfFloors, earningsFromClients, requestsOfFloorsFromClients)
                                    ),
                                )
                                ),
                              );
                              print("Start Game ${index+1} pressed");
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