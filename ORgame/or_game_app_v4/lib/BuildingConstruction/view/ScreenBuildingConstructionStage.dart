import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:or_game_app_v4/view/IconWidget.dart';
import 'package:or_game_app_v4/view/ScreenMainMenu.dart';

import '../../language.dart';
import '../../style.dart';
import 'ScreenBuildingConstructionLevel.dart';

// stateful widget
class ScreenBuildingConstructionStage extends StatefulWidget {
  Language lang;
  ScreenBuildingConstructionStage(this.lang);
  // overriding the createState method
  @override
  State<StatefulWidget> createState() => ScreenBuildingConstructionStageState(this.lang);

}

//the state
class ScreenBuildingConstructionStageState extends State<ScreenBuildingConstructionStage> {

  Language lang;
  ScreenBuildingConstructionStageState(this.lang);
  List listOfDifficulties;

  // method to load Json data
  Future<String> loadJsonData() async {
    var jsonText = await rootBundle.loadString(
        'assets/problemInstances/BuildingConstruction/BuildingConstructionDifficulties.json');
    setState(() => listOfDifficulties = json.decode(jsonText));
    return 'success';
  }

  @override
  void initState() {
    super.initState();
    this.loadJsonData();
  }

  //the build method
  @override
  Widget build(BuildContext context) {
    return Column(
      children : [
        Container(
            height : MediaQuery.of(context).padding.top,
            width : MediaQuery.of(context).size.width,
            color : Colors.black
        ),
        Container(
          height : MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top,
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
                          child: Text('Return'),
                          style: Style.returnButtonText,
                          onPressed: () {
                            Navigator.of(context).push( //Navigateur vers widget
                              MaterialPageRoute(builder: (context)=>
                                  ScreenMenuPrincipal(this.lang),
                              ),
                            );
                          },
                        )
                    ),
                  ),
                  Text('Choose a difficulty',style : TextStyle(
                    fontSize: 18, color: Colors.black, fontWeight: FontWeight.bold, decoration: TextDecoration.none),
                  ),
                  Expanded(
                      child: ListView.separated(
                        padding: const EdgeInsets.all(8),
                        itemCount: listOfDifficulties==null ? 0 : listOfDifficulties.length, //checking if entries is null or not
                        itemBuilder: (BuildContext context, int index) {
                          var difficulty_textEN = listOfDifficulties[index]['difficultyEN'];
                          var difficulty_textFR = listOfDifficulties[index]['difficultyFR'];
                          return ElevatedButton(
                            child: Text('$difficulty_textEN'),
                            style: Style.buttonText,
                            onPressed: () {
                              Navigator.of(context).push( //Navigateur vers widget
                                MaterialPageRoute(builder: (context)=>
                                    ScreenBuildingConstructionLevel(difficulty_textEN, this.lang), // do not change this text, it mus be in english
                                ),
                              );
                              print("Start Game $difficulty_textEN pressed");
                            },
                          );
                        },
                        separatorBuilder: (BuildContext context, int index) => const Divider(),
                      )
                  )
                ]
              ),
              IconWidget(Axis.horizontal, this.lang)
            ]
          )
        )
      ]
    );
  }
}
