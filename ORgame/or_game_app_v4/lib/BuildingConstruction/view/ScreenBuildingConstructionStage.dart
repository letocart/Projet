import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:or_game_app_v4/database/BuildingConstructionDatabaseHelper.dart';
import 'package:or_game_app_v4/view/ScreenMainMenu.dart';

import '../../style.dart';
import 'ScreenBuildingConstructionLevel.dart';
class ScreenBuildingConstructionStage extends StatelessWidget {
  final List<String> entries = <String>['Tutorial', 'Easy', 'Normal', 'Hard', 'Insane'];

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
                                  ScreenMenuPrincipal(),
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
                        itemCount: entries.length,
                        itemBuilder: (BuildContext context, int index) {
                          return ElevatedButton(
                            child: Text('${entries[index]}'),
                            style: Style.buttonText,
                            onPressed: () {
                              Navigator.of(context).push( //Navigateur vers widget
                                MaterialPageRoute(builder: (context)=>
                                    ScreenBuildingConstructionLevel(entries[index]),
                                ),
                              );
                              print("Start Game ${entries[index]} pressed");
                            },
                          );
                        },
                        separatorBuilder: (BuildContext context, int index) => const Divider(),
                      )
                  )
                ])
        ),
        Positioned(
            top: 0.0,
            left: 0.0,
            child: Row(
              children: [
                Material(
                  color : Colors.transparent,
                  child: Ink(
                      decoration: const ShapeDecoration(
                          color: Colors.transparent,
                          shape: CircleBorder()),
                      child : IconButton(
                        icon: Image.asset('assets/images/icon/uk.png'),
                        onPressed: () {},
                      )
                  ),
                ),
                Material(
                  color : Colors.transparent,
                  child: Ink(
                      decoration: const ShapeDecoration(
                          color: Colors.transparent,
                          shape: CircleBorder()),
                      child : IconButton(
                        icon: Image.asset('assets/images/icon/fr.png'),
                        onPressed: () {},
                      )
                  ),
                ),
                Material(
                  color : Colors.transparent,
                  child: Ink(
                      decoration: const ShapeDecoration(
                          color: Colors.transparent,
                          shape: CircleBorder()),
                      child : IconButton(
                        icon: Image.asset('assets/images/icon/manual.png'),
                        onPressed: () {},
                      )
                  ),
                )
              ],
            )
        )
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