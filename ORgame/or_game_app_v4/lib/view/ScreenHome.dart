import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:or_game_app_v4/StorageUtil.dart';
import '../style.dart';
import 'package:flutter/services.dart';
import 'IconWidget.dart';
import 'ScreenMainMenu.dart';

/// View widget to display the home screen
class ScreenHome extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => ScreenHomeState();
}

/// State class of ScreenHome widget
class ScreenHomeState extends State<ScreenHome> {

  @override
  /// Initiating state
  void initState() {
    super.initState();
  }

  @override
  /// The build method of ScreenHome
  Widget build(BuildContext context) {
    return Column(
      children : [
        // Container to add a padding at the top of the screen for the phone's status bar
        Container(
          height: MediaQuery.of(context).padding.top, // Height of the status bar
          width: MediaQuery.of(context).size.width, // Width of the screen
          color: Colors.black,
        ),
        // Main Container
        Container(
          height:  MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top,
          width: MediaQuery.of(context).size.width,
          // Decoration to add a background
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/backgrounds/city3.png"),
              fit: BoxFit.cover
            )
          ),
          alignment: Alignment.center,
          child: Stack(
            children : [
              // Center of the screen
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children : [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children :  [
                      // Add a space
                      SizedBox(
                        height : 50,
                      ),
                      // Screen's title : Welcome to the game
                      Stack(
                        children: [
                          // Welcome text white outline
                          Text(
                            getText('welcomeText'),
                            style : TextStyle(
                              fontSize: 18,
                              foreground: Paint()
                                ..style = PaintingStyle.stroke
                                ..strokeWidth = 2.5
                                ..color = Colors.white,
                              fontWeight: FontWeight.bold, decoration: TextDecoration.none
                            ),
                          ),
                          // Welcome text
                          Text(
                            getText('welcomeText'),
                            style : TextStyle(
                              fontSize: 18,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              decoration: TextDecoration.none
                            ),
                          )
                        ],
                      ),
                      // Add a space
                      SizedBox(
                        height : 20,
                      ),
                      // Button to start the game
                      ElevatedButton(
                        child: Text(getText('startGameButtonText')),
                        style: Style.buttonText,
                        onPressed: () {
                          Navigator.of(context).push( //Navigator to ScreenMainMenu widget
                            MaterialPageRoute(builder: (context)=>
                                ScreenMainMenu(),
                            ),
                          );
                        },
                      ),
                      // Button to exit the game
                      ElevatedButton(
                        child: Text(getText('exitGameButtonText'),style: TextStyle(color:Colors.black),),
                        style: Style.exitButtonText,
                        onPressed: () {
                          SystemNavigator.pop();
                        },
                      ),
                    ],
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