import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import '../language.dart';
import '../style.dart';
import 'package:flutter/services.dart';
import 'IconWidget.dart';
import 'ScreenMainMenu.dart';

class ScreenHome extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => ScreenHomeState();
}

class ScreenHomeState extends State<ScreenHome> {
  Language lang;

  @override
  void initState() {
    super.initState();
    lang = new Language();
  }

  String title()
  {
    if(lang.getLanguage()=="English")
      return 'Welcome to playing OR';
    else if(lang.getLanguage()=="French")
      return 'Jouons à la RO';
    else
      return "ERROR";
  }

  @override
  Widget build(BuildContext context) {
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
                        Text(this.title(),style : TextStyle(
                            fontSize: 18, color: Colors.black,fontWeight: FontWeight.bold, decoration: TextDecoration.none),
                        ),
                        SizedBox(
                          height : 20,
                        ),
                        ElevatedButton(
                          child: Text('Start Game'),
                          style: Style.buttonText,
                          onPressed: () {
                            Navigator.of(context).push( //Navigateur vers widget
                            MaterialPageRoute(builder: (context)=>
                                ScreenMenuPrincipal(this.lang),
                            ),
                          );
                            print("Start Game pressed");
                          },
                        ),
                        ElevatedButton(
                          child: Text('Exit',style: TextStyle(color:Colors.black),),
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
                IconWidget(Axis.horizontal, this.lang)
              ]
            )
          )
      ]
    );
  }
}