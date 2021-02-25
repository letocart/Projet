import 'package:flutter/material.dart';
import 'package:flutter_prototype1/widgets/ScreenDistiServStage.dart';
import '../style.dart';

class ScreenMenuPrincipal extends StatelessWidget {
  @override
  Widget build(BuildContext context){
    return Container(
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/images/backgrounds/city2.jpg"),
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
                        padding: EdgeInsets.all(16.0),
                        child : Image.asset('assets/images/professeur.png', scale : 10.0)
                    )
                )
            )
          ),
          Expanded(
              flex : 1,
              child : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children : [
                  RaisedButton(
                      onPressed: () {
                        print("jeu 1 pressed");
                        Navigator.of(context).push( //Navigateur vers widget
                          MaterialPageRoute(builder: (context)=>
                              ScreenDistriServStage(),
                          ),
                        );
                      },
                      color : Colors.orange,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(30))),
                      child: Text('Game 1',style: TextStyle(color:Colors.black),)
                  ),
                  RaisedButton(
                      onPressed: () {
                        print("Jeu 2 pressed");
                      },
                      color : Colors.orange,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(30))),
                      child: Text('Game 2',style: TextStyle(color:Colors.black),)
                  ),
                ],
              )
          ),
        ],
      ),
    );
  }
}