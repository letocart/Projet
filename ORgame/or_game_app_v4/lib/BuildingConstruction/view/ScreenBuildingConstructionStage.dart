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
  //final List<String> entries = <String>['Tutorial', 'Easy', 'Normal', 'Hard', 'Insane'];
  Language lang;
  ScreenBuildingConstructionStage(this.lang);
  // overriding the createState method
  @override
  State<StatefulWidget> createState() => ScreenBuildingConstructionStageState(this.lang);

}

//the state
class ScreenBuildingConstructionStageState extends State<ScreenBuildingConstructionStage> {
  //list of difficulties
  Language lang;
  ScreenBuildingConstructionStageState(this.lang);
  List entries;
  Future<String> loadJsonData() async {
    var jsonText = await rootBundle.loadString(
        'assets/problemInstances/BuildingConstruction/BuildingConstructionDifficulties.json');
    setState(() => entries = json.decode(jsonText));
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
                          itemCount: entries==null ? 0 : entries.length, //checking if entries is null or not
                          itemBuilder: (BuildContext context, int index) {
                            var difficulty_textEN = entries[index]['difficultyEN'];
                            var difficulty_textFR = entries[index]['difficultyEN'];
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
                  ])
          ),
          IconWidget(Axis.horizontal, this.lang)
        ]

    );
  }
}

/*class ScreenBuildingConstructionStage extends StatelessWidget {
  final List<String> entries = <String>['Tutorial', 'Easy', 'Normal', 'Hard', 'Insane'];

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/images/backgrounds/city3.jpg"),
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
                      child: Text('Return'),
                      style: Style.returnButtonText,
                      onPressed: () {
                        Navigator.of(context).push( //Navigateur vers widget
                          MaterialPageRoute(builder: (context)=>
                              ScreenMenuPrincipal(),
                          ),
                        );
                      },
                    )
                ),
              ),
              Text('Choose a difficulty dood',style : TextStyle(
                  fontSize: 18, color: Colors.black, fontWeight: FontWeight.bold, decoration: TextDecoration.none),
              ),
              FutureBuilder(
                future: BuildingConstructionDatabaseHelper.instance.queryAllRows(),
                builder: (BuildContext context, AsyncSnapshot<List<Map<String, dynamic>>> snapshot) {
                  if (snapshot.hasData) {
                    return Expanded(
                        child: ListView.separated(
                          padding: const EdgeInsets.all(8),
                          itemCount: snapshot.data.length,
                          itemBuilder: (BuildContext context, int index) {
                            print('${snapshot.data[index]['columnDifficulte']}');
                            return Text(
                              '${snapshot.data[index]['columnDifficulte']}'
                            );
                          },
                          separatorBuilder: (BuildContext context, int index) => const Divider(),
                        )
                    );
                  } else {
                    print('Pas de data');
                    return Container();
                  }
                }
              )
            ])
    );
  }
}*/