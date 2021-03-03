import 'package:flutter/material.dart';
import 'package:flutter_prototype1/style.dart';
import 'package:flutter_prototype1/DistributionServices/view/ScreenDistriServLevel.dart';
import 'package:flutter_prototype1/DistributionServices/data/DistributionServicesData.dart';

class ScreenDistriServGame extends StatefulWidget {
  String difficulty;
  int level;
  ScreenDistriServGame(String diff, int lvl) {
    difficulty = diff;
    level = lvl;
  }

  createState() => ScreenDistriServGameState(difficulty, level);
}

class ScreenDistriServGameState extends State<ScreenDistriServGame> {
  String difficulty;
  int level;

  final DistributionServicesData data = new DistributionServicesData(300
      , 2, 5, [0, 100, 200, 300, 400]
      , [200, 300, 400, 500, 600, 700, 800], [2, 3, 4, 5, 6, 7, 8]);

  int score = 0;

  ScreenDistriServGameState(String diff, int lvl) {
    difficulty = diff;
    level = lvl;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.teal
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
                    SizedBox(
                      width : 65,
                      height : 300,
                      child : Expanded(
                        child : ListView.separated(
                                padding: const EdgeInsets.all(8),
                                itemCount: data.gains.length,
                                scrollDirection: Axis.vertical,
                                shrinkWrap: true,
                                itemBuilder: (BuildContext context, int index) {
                                  print('data $index = ${data.gains[index]}');
                                  return SizedBox(
                                    height : 50,
                                    width : 50,
                                    child : Draggable<double>(
                                      data: data.gains[index],
                                      child: Client(data.gains[index].toInt()),
                                      feedback : Client(data.gains[index].toInt())
                                    )
                                  );
                                },
                                separatorBuilder: (BuildContext context, int index) => const Divider()
                              )
                      )
                    )
                  ]
                ),
            Text('Score $score',style : TextStyle(fontSize: 18, color: Colors.black, fontWeight: FontWeight.bold, decoration: TextDecoration.none))
          ]
      ),
    );
  }

  Widget _buildDragTarget() {
    return DragTarget<String>(
      builder: (BuildContext context, List<String> incoming, List rejected) {
        return Container(
            decoration: BoxDecoration(
              color: Colors.white70,
              border: Border.all(
                color: Colors.black,
                width: 1,
              ),
            ),
            height: 50,
            width: 50
        );
      },
      onWillAccept: (data) => true,
      onAccept: (data) {
        setState(() {true;});
      },
      onLeave: (data) {},
    );
  }
}

class Client extends StatelessWidget {
  Client(this.gain);

  final int gain;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.red,
      child: Container(
        alignment: Alignment.center,
        height: 50,
        width : 50,
        child: Text(
          '$gain',
          style: TextStyle(color: Colors.black, fontSize: 10),
        ),
      ),
    );
  }
}

/*
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
              color: Colors.teal
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
          return Container(
              decoration: BoxDecoration(
                color: Colors.white70,
                border: Border.all(
                  color: Colors.black,
                  width: 1,
                ),
              ),
              height: 50,
              width: 50
          );
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
*/

