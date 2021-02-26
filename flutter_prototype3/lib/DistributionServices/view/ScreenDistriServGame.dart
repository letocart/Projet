import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_prototype1/style.dart';

import 'ScreenDistriServLevel.dart';

class ScreenDistriServGame extends StatelessWidget {
  String difficulty;
  int level;

  ScreenDistriServGame(String diff, int level) {
    difficulty = diff;
    print(difficulty);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          image: DecorationImage(
          image: AssetImage("assets/images/backgrounds/city2.jpg"),
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
                        ScreenDistriServLevel(difficulty),
                    ),
                  );
                },
              )
            ),
          )
        ]
      )
    );
  }
}