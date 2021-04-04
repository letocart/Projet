import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:or_game_app_v4/view/IconWidget.dart';

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
  List data;
  int numberOfLevels=0;
  String difficulty;
  ScreenBuildingConstructionLevelState(String diff) {
    difficulty = diff;
    print(difficulty);
  }

  Future<String> loadJsonData() async {
    var jsonText = await rootBundle.loadString('assets/problemInstances/BuildingConstruction/'
            'BuildingConstruction_'+difficulty+'_Levels.json');
    setState(() => data = json.decode(jsonText));
    return 'success';
  }

  @override
  void initState() {
    super.initState();
    this.loadJsonData();
  }

  @override
  Widget build(BuildContext context) {
    numberOfLevels = data==null ? 0 : data[0]['numberOfLevels'];
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
                            children:
                            List.generate(numberOfLevels, (index) {
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
          IconWidget(Axis.horizontal)
        ]

    );
  }

}