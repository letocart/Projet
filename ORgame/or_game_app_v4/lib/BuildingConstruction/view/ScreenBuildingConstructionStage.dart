import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:or_game_app_v4/view/IconWidget.dart';
import 'package:or_game_app_v4/view/ScreenMainMenu.dart';

import '../../StorageUtil.dart';
import '../../style.dart';
import 'ScreenBuildingConstructionLevel.dart';

// stateful widget
class ScreenBuildingConstructionStage extends StatefulWidget {
  List dataInstances;
  ScreenBuildingConstructionStage(this.dataInstances);
  // overriding the createState method
  @override
  State<StatefulWidget> createState() => ScreenBuildingConstructionStageState(this.dataInstances);

}

//the state
class ScreenBuildingConstructionStageState extends State<ScreenBuildingConstructionStage> {
  List dataInstances;
  ScreenBuildingConstructionStageState(this.dataInstances);

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
                          child: Text(getText('returnButtonText')),
                          style: Style.returnButtonText,
                          onPressed: () {
                            Navigator.of(context).push( //Navigateur vers widget
                              MaterialPageRoute(builder: (context)=>
                                  ScreenMainMenu(),
                              ),
                            );
                          },
                        )
                    ),
                  ),
                  Stack(
                    children: [
                      Text(getText('chooseDifficultyText'),style : TextStyle(
                          fontSize: 18,
                          foreground: Paint()
                            ..style = PaintingStyle.stroke
                            ..strokeWidth = 2.5
                            ..color = Colors.white,
                          fontWeight: FontWeight.bold, decoration: TextDecoration.none),
                      ),
                      Text(getText('chooseDifficultyText'),style : TextStyle(
                        fontSize: 18, color: Colors.black, fontWeight: FontWeight.bold, decoration: TextDecoration.none),
                      )
                    ],
                  ),
                  Expanded(
                      child: ListView.separated(
                        padding: const EdgeInsets.all(8),
                        itemCount: dataInstances==null ? 0 : dataInstances.length, //checking if entries is null or not
                        itemBuilder: (BuildContext context, int difficultyIndex) {
                          var difficultyText = dataInstances[difficultyIndex]['difficulty'+StorageUtil.getString('lang')];
                          return ElevatedButton(
                            child: Text('$difficultyText'),
                            style: Style.buttonText,
                            onPressed: () {
                              Navigator.of(context).push( //Navigateur vers widget
                                MaterialPageRoute(builder: (context)=>
                                    ScreenBuildingConstructionLevel(dataInstances,difficultyIndex), // do not change this text, it mus be in english
                                ),
                              );
                              //print("Start Game $difficulty_textEN pressed");
                            },
                          );
                        },
                        separatorBuilder: (BuildContext context, int index) => const Divider(),
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
