import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import '../style.dart';
import 'package:flutter/services.dart';
import 'ScreenMainMenu.dart';


// widget ecran titre
class ScreenHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children : [
        Container(
          // Principal container
            decoration: BoxDecoration(  // background
                image: DecorationImage(
                    image: AssetImage("assets/images/backgrounds/city3.png"), // image du background
                    fit: BoxFit.cover //couvre tout l'ecran
                )
            ),
            alignment: Alignment.center, // s'alligne au centre
            child : Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children : [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children :  [

                      SizedBox( //Sized Box d'ecart
                        height : 50,
                      ),
                      Text('Welcome to OR Game',style : TextStyle(
                          fontSize: 18, color: Colors.black,fontWeight: FontWeight.bold),
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
                                ScreenMenuPrincipal(),
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
            )
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
        ),
      ]
    );
  }
}
