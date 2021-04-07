import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:or_game_app_v4/StorageUtil.dart';
import '../style.dart';
import 'package:flutter/services.dart';
import 'IconWidget.dart';
import 'ScreenMainMenu.dart';

class ScreenHome extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => ScreenHomeState();
}

class ScreenHomeState extends State<ScreenHome> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //print("I am the Home Language: "+StorageUtil.getString("lang"));
    return Column(
        children : [
          Container(
            height: MediaQuery.of(context).padding.top,
            width: MediaQuery.of(context).size.width,
            color: Colors.black,
          ),
          Container(
            height:  MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(  // background
                image: DecorationImage(
                    image: AssetImage("assets/images/backgrounds/city3.png"), // image du background
                    fit: BoxFit.cover //couvre tout l'ecran
                )
            ),
            alignment: Alignment.center,
            child: Stack(
              children : [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children : [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children :  [
                        SizedBox( //Sized Box d'ecart
                          height : 50,
                        ),
                        Text(getText('welcomeText'),style : TextStyle(
                            fontSize: 18, color: Colors.black,fontWeight: FontWeight.bold, decoration: TextDecoration.none),
                        ),
                        SizedBox(
                          height : 20,
                        ),
                        ElevatedButton(
                          child: Text(getText('startGameButtonText')),
                          style: Style.buttonText,
                          onPressed: () {
                            Navigator.of(context).push( //Navigateur vers widget
                            MaterialPageRoute(builder: (context)=>
                                ScreenMainMenu(),
                            ),
                          );
                            print("Start Game pressed");
                          },
                        ),
                        ElevatedButton(
                          child: Text(getText('exitGameButtonText'),style: TextStyle(color:Colors.black),),
                          style: Style.exitButtonText,
                          onPressed: () {
                            SystemNavigator.pop();
                            print("Exit pressed");
                          },
                        ),
                      ],
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