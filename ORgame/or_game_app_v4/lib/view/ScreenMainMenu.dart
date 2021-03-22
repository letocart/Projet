import 'package:flutter/material.dart';
import 'package:or_game_app_v4/BuildingConstruction/view/ScreenBuildingConstructionStage.dart';
import '../style.dart';

class ScreenMenuPrincipal extends StatelessWidget {
  @override
  Widget build(BuildContext context){
    return Container(
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/images/backgrounds/city3.png"),
              fit: BoxFit.cover)),
      child : Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children : [
          Expanded(
            flex : 1,
            child : Container(
                child : Align(
                    alignment : Alignment.bottomLeft,
                    child : Padding (
                        padding: EdgeInsets.only(left: 16.0),
                        child : Image.asset('assets/images/John.png', scale : 10.0)
                    )
                )
            )
          ),
          Expanded(
              flex : 1,
              child : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children : [
                  ElevatedButton(
                      child: Text('Game 1'),
                      style: Style.buttonText,
                      onPressed: () {
                        print("jeu 1 pressed");
                        Navigator.of(context).push( //Navigateur vers widget
                          MaterialPageRoute(builder: (context)=>
                              ScreenBuildingConstructionStage(),
                          ),
                        );
                      },
                  ),
                  ElevatedButton(
                      child: Text('Game 2'),
                      style: Style.buttonText,
                      onPressed: () {
                        print("Jeu 2 pressed");
                      },
                  ),
                ],
              )
          ),
        ],
      ),
    );
  }
}