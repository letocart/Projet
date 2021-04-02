import 'package:flutter/material.dart';
import 'package:or_game_app_v4/BuildingConstruction/view/ScreenBuildingConstructionStage.dart';
import '../style.dart';
import 'package:bubble/bubble.dart';
import 'IconWidget.dart';
import 'ScreenHome.dart';

class ScreenMenuPrincipal extends StatelessWidget {
  @override
  Widget build(BuildContext context){
    return Stack (
      children : [
        Container (
          // Principal container
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
                      child :
                        Align(
                          alignment : Alignment.bottomLeft,
                          child : Padding (
                              padding: EdgeInsets.only(left: 16.0),
                              child : Image.asset('assets/images/John.png', scale : 10.0)
                          )
                      )
                  )
              ),
              Expanded(
                  flex : 2,
                  child : Bubble(
                    alignment: Alignment.centerLeft,
                    radius: Radius.circular(20.0),
                    margin: BubbleEdges.only(top: 10),
                    color: Color.fromRGBO(255, 165, 0, 2.0),
                    stick: true,
                    nip: BubbleNip.leftBottom,
                    child: Text(
                        'Welcome to the city of OR !'
                            '\nWe need to manage many thing in order to build the perfect and most optimized city ever!'
                            '\nSelect which game you want to play by pressing Game1 or Game2',
                      style: TextStyle(
                          color: Colors.white,
                          decoration: TextDecoration.none,
                          height: 2,
                          fontSize: 10
                      ),
                    ),
                  ),
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
              Align(
                  alignment: Alignment.topRight,
                  child: Padding(
                      padding: EdgeInsets.all(5.0),
                      child: ElevatedButton(
                        child: Text('Return'),
                        style: Style.returnButtonText,
                        onPressed: () {
                          Navigator.of(context).push( //Navigateur vers widget
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
        ),
        IconWidget(Axis.horizontal)
      ]
    );
  }
}