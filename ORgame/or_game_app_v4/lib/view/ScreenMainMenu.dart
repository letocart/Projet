import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:or_game_app_v4/BuildingConstruction/view/ScreenBuildingConstructionStage.dart';
import '../StorageUtil.dart';
import '../style.dart';
import 'package:bubble/bubble.dart';
import 'IconWidget.dart';
import 'ScreenHome.dart';

/// View widget to display the level selection screen of the Building Construction game
class ScreenMainMenu extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => ScreenMainMenuState();
}

/// State class of ScreenMainMenuState widget
class ScreenMainMenuState extends State<ScreenMainMenu> {

  List BuildingConstructionDataInstances;

  /// Method to load Json data
  Future<String> loadJsonData() async {
    print("test_load_Json_Data");
    var jsonText = await rootBundle.loadString(
        'assets/problemInstances/BuildingConstructionInstances.json');
    setState(() => BuildingConstructionDataInstances = json.decode(jsonText));
    return 'success';
  }

  @override
  /// Initiating state
  void initState() {
    super.initState();
    this.loadJsonData();
  }

  /// The build method of ScreenMainMenuState
  @override
  Widget build(BuildContext context){
    return Column(
      children : [
        // Container to add a padding at the top of the screen for the phone's status bar
        Container(
          height: MediaQuery.of(context).padding.top, // Height of the status bar
          width: MediaQuery.of(context).size.width, // Width of the screen
          color: Colors.black,
        ),
        // Main container
        Container(
          height: MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top,
          width: MediaQuery.of(context).size.width,
          // Decoration to add a background
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/backgrounds/city3.png"),
              fit: BoxFit.cover
            )
          ),
          child: Stack (
            children : [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children : [
                  // John in the bottom left of the screen
                  Expanded(
                    flex : 1,
                    child : Align(
                      alignment : Alignment.bottomRight,
                      child : Padding (
                        padding: EdgeInsets.only(left: 16.0),
                        child : Image.asset('assets/images/John.png', scale : 10.0)
                      )
                    )
                  ),
                  // John's bubble text
                  Expanded(
                    flex : 2,
                    child : Bubble(
                      alignment: Alignment.centerLeft,
                      radius: Radius.circular(20.0),
                      margin: BubbleEdges.only(top: 70),
                      color: Color.fromRGBO(255, 165, 0, 2.0),
                      stick: true,
                      nip: BubbleNip.leftBottom,
                      child: Text(
                        getText('introductionText'),
                        textAlign: TextAlign.justify,
                        style: TextStyle(
                          color: Colors.white,
                          decoration: TextDecoration.none,
                          height: 2,
                          fontSize: 10
                        )
                      ),
                    ),
                  ),
                  // Buttons to choose a game
                  Expanded(
                    flex : 1,
                    child : Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children : [
                        // Button to play the Building Construction game
                        ElevatedButton(
                          child: Text(getText('gameName1')),
                          style: Style.buttonText,
                          onPressed: () async {
                            await loadJsonData();
                            Navigator.of(context).push( //Navigator to ScreenBuildingConstructionStage widget
                              MaterialPageRoute(builder: (context)=>
                                  ScreenBuildingConstructionStage(BuildingConstructionDataInstances),
                              ),
                            );
                          },
                        ),
                        // Button to play the second game (coming soon)
                        ElevatedButton(
                          child: Text(getText('gameName2')),
                          style: Style.buttonText,
                          onPressed: () {
                            //print("Jeu 2 pressed");
                          },
                        ),
                      ],
                    )
                  ),
                  // Return to previous screen button at the top right of the screen
                  Align(
                    alignment: Alignment.topRight,
                    child: Padding(
                      padding: EdgeInsets.all(5.0),
                      child: ElevatedButton(
                        child: Text(getText('returnButtonText')),
                        style: Style.returnButtonText,
                        onPressed: () {
                          Navigator.of(context).push( //Navigator ScreenHome widget
                            MaterialPageRoute(builder: (context)=>
                                ScreenHome(),
                            ),
                          );
                        },
                      )
                    )
                  ),
                ],
              ),
              // Languages and manual icons at the top left of the screen
              IconWidget(Axis.horizontal,this)
            ]
          )
        )
      ]
    );
  }
}