import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:playing_or/view/IconWidget.dart';
import 'package:playing_or/view/ScreenMainMenu.dart';
import 'package:playing_or/view/StatusBar.dart';

import '../../StorageUtil.dart';
import '../../style.dart';
import 'ScreenBuildingConstructionLevel.dart';

/// View widget to display the difficulty selection screen of the Building Construction game
class ScreenBuildingConstructionStage extends StatefulWidget {
  List dataInstances;
  ScreenBuildingConstructionStage(this.dataInstances);

  // overriding the createState method
  @override
  State<StatefulWidget> createState() => ScreenBuildingConstructionStageState(this.dataInstances);
}

/// State class of ScreenBuildingConstructionStage widget
class ScreenBuildingConstructionStageState extends State<ScreenBuildingConstructionStage> {
  List dataInstances;
  ScreenBuildingConstructionStageState(this.dataInstances);

  /// The build method of ScreenBuildingConstructionStage
  @override
  Widget build(BuildContext context) {
    return Column(
      children : [
        // StatusBar
        StatusBar(),
        // Main container with a background
        Container(
          height : MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top, // height of the screen minus the height of the status bar
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
                        child: Text(getText('returnButtonText')),
                        style: Style.returnButtonText,
                        onPressed: () {
                          Navigator.of(context).push( //Navigator to ScreenMainMenu widget
                            MaterialPageRoute(builder: (context)=>
                                ScreenMainMenu(),
                            ),
                          );
                        },
                      )
                    ),
                  ),
                  // Screen's title
                  Stack(
                    children: [
                      // Text's white outline
                      Text(
                        getText('chooseDifficultyText'),
                        style : TextStyle(
                          fontSize: 18,
                          foreground: Paint()
                            ..style = PaintingStyle.stroke
                            ..strokeWidth = 2.5
                            ..color = Colors.white,
                          fontWeight: FontWeight.bold, decoration: TextDecoration.none
                        ),
                      ),
                      // Title text
                      Text(
                        getText('chooseDifficultyText'),
                        style : TextStyle(
                          fontSize: 18, color: Colors.black, fontWeight: FontWeight.bold, decoration: TextDecoration.none
                        ),
                      )
                    ],
                  ),
                  // List of difficulties
                  Expanded(
                    child: ListView.separated(
                      padding: const EdgeInsets.all(8),
                      itemCount: dataInstances==null ? 0 : dataInstances.length, //checking if entries is null or not
                      itemBuilder: (BuildContext context, int difficultyIndex) {
                        var difficultyText = dataInstances[difficultyIndex]['difficulty'+StorageUtil.getString('lang')];
                        // Creation of each difficulty button
                        return ElevatedButton(
                          child: Text('$difficultyText'),
                          style: Style.buttonText,
                          onPressed: () {
                            Navigator.of(context).push( //Navigator to ScreenBuildingConstructionLevel widget
                              MaterialPageRoute(builder: (context)=>
                                  ScreenBuildingConstructionLevel(dataInstances,difficultyIndex), // do not change this text, it must be in english
                              ),
                            );
                          },
                        );
                      },
                      separatorBuilder: (BuildContext context, int index) => const Divider(),
                    )
                  )
                ]
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
