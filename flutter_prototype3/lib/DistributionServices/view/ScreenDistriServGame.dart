/*import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_prototype1/style.dart';


import 'ScreenDistriServLevel.dart';*/

/*class ScreenDistriServGame extends StatelessWidget {
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
}*/

import 'package:flutter/material.dart';
import 'dart:math';
import 'package:flutter_prototype1/style.dart';
import 'package:flutter_prototype1/DistributionServices/view/ScreenDistriServLevel.dart';

class ScreenDistriServGame extends StatefulWidget {
  String difficulty;
  int level;
  ScreenDistriServGame(String diff, int level) {
    difficulty = diff;
    print(difficulty);
  }
  /*
  @override
  Widget build(BuildContext context) {
    return ColorGame();
  }
  */

  createState() => ScreenDistriServGameState(difficulty, level);
}

class ScreenDistriServGameState extends State<ScreenDistriServGame> {
  String difficulty;
  int level;
  ScreenDistriServGameState(String diff, int level) {
    difficulty = diff;
    print(difficulty);
  }
  /// Map to keep track of score
  final Map<String, bool> score = {};

  /// Choices for game
  final Map choices = {
    '🍏': Colors.green,
    '🍋': Colors.yellow,
    '🍅': Colors.red,
    '🍇': Colors.purple,
    '🥥': Colors.brown,
    '🥕': Colors.orange
  };

  // Random seed to shuffle order of items.
  int seed = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/images/backgrounds/city2.jpg"),
              fit: BoxFit.cover)
      ),
      child: Column (
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
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children:
                        choices.keys.map((emoji) => _buildDragTarget(emoji)).toList()
                          ..shuffle(Random(seed)),
                      ),
                Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: choices.keys.map((emoji) {
                      return Draggable<String>(
                        data: emoji,
                        child: Emoji(emoji: score[emoji] == true ? '✅' : emoji),
                        feedback: Emoji(emoji: emoji),
                        childWhenDragging: Emoji(emoji: '🌱'),
                      );
                    }).toList()),
              ],
            ),
            Text('Score ${score.length}',style : TextStyle(fontSize: 18, color: Colors.black, fontWeight: FontWeight.bold, decoration: TextDecoration.none))

          ]
      ),
    );
  }

  Widget _buildDragTarget(emoji) {
    return DragTarget<String>(
      builder: (BuildContext context, List<String> incoming, List rejected) {
        if (score[emoji] == true) {
          return Container(
            color: Colors.white,
            child: Text('Correct!',style : TextStyle(fontSize: 18, color: Colors.black, fontWeight: FontWeight.bold, decoration: TextDecoration.none)),
            alignment: Alignment.center,
            height: 50,
            width: 200,
          );
        } else {
          return Container(color: choices[emoji], height: 50, width: 200);
        }
      },
      onWillAccept: (data) => data == emoji,
      onAccept: (data) {
        setState(() {
          score[emoji] = true;
        });
      },
      onLeave: (data) {},
    );
  }
}

class Emoji extends StatelessWidget {
  Emoji({Key key, this.emoji}) : super(key: key);

  final String emoji;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Container(
        alignment: Alignment.center,
        height: 50,
        padding: EdgeInsets.all(10),
        child: Text(
          emoji,
          style: TextStyle(color: Colors.black, fontSize: 50),
        ),
      ),
    );
  }
}