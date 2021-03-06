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
  bool successfulDrop = false;

  final DistributionServicesData data = new DistributionServicesData(300
      , 2, 5, [0, 100, 200, 300, 400]
      , [200, 300, 400, 500, 600, 700, 800], [2, 3, 4, 5, 6, 7, 8]);

  int score = 0;

  ScreenDistriServGameState(String diff, int lvl) {
    difficulty = diff;
    level = lvl;
  }
  int acceptedData = 0;
  @override
  Widget build(BuildContext context) {
    return /*Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Draggable<int>(
          // Data is the value this Draggable stores.
          data: 10,
          child: Container(
            height: 100.0,
            width: 100.0,
            color: Colors.lightGreenAccent,
            child: Center(
              child: Text("Draggable"),
            ),
          ),
          feedback: Container(
            color: Colors.deepOrange,
            height: 100,
            width: 100,
            child: Icon(Icons.directions_run),
          ),
          childWhenDragging: Container(
            height: 100.0,
            width: 100.0,
            color: Colors.pinkAccent,
            child: Center(
              child: Text("Child When Dragging"),
            ),
          ),
        ),
        DragTarget(
          builder: (
              BuildContext context,
              List<dynamic> accepted,
              List<dynamic> rejected,
              ) {
            return Container(
              height: 100.0,
              width: 100.0,
              color: Colors.cyan,
              child: Center(
                child: Text("Value is updated to: $acceptedData"),
              ),
            );
          },
          onAccept: (int data) {
            print("J'ai tout casse");
            setState(() {
              acceptedData += data;
            });
          },
        ),
      ],
    );*/
    Container(
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
                Container(
                  width : MediaQuery.of(context).size.width * 0.70,
                  height: MediaQuery.of(context).size.height * 0.75,
                  child: Align(
                    child : _buildDragTarget()
                  )
                ),
                Container(
                  width : MediaQuery.of(context).size.width * 0.30,
                  height: MediaQuery.of(context).size.height * 0.75,
                  child: GridView.count(
                    padding: const EdgeInsets.all(8),
                    crossAxisSpacing: 20,
                    mainAxisSpacing: 20,
                    crossAxisCount: 3,
                    children: List.generate(data.gains.length, (index) {
                      return Align(
                          alignment: Alignment.topLeft,
                          child: Container(
                            //margin: EdgeInsets.only(right: (MediaQuery.of(context).size.width*0.3-50)/2, left: (MediaQuery.of(context).size.width*0.3-50)/2),
                            height : 50,
                            width : 50,
                            child : Client_Draggable(data.gains[index].toInt())
                            /*child : Draggable<double>(
                              data: data.gains[index],
                              child: Client(data.gains[index].toInt()),
                              feedback : Client(data.gains[index].toInt())
                            )*/
                          )
                      );
                    })
                  ),
                )
              ]
            ),
            Text('Score $score',style : TextStyle(fontSize: 18, color: Colors.black, fontWeight: FontWeight.bold, decoration: TextDecoration.none))
          ]
      ),
    );
  }

  Widget _buildDragTarget() {
    return DragTarget<int>(
      builder: (BuildContext context, List<int> incoming, List rejected) {
        print(incoming.length);
        if(successfulDrop == true){
          return Container(
              color: Colors.red,
              height: 50,
              width: 50
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
      onWillAccept: (data){
        print("OnWillAccept");
        return true;
      },
      onAccept: (data) {
        print("Accept");
        setState(() {
          successfulDrop = true;
        });
      },
      onLeave: (data) {
        print("Not accept");
      },
    );
  }
}

class Client_Draggable extends StatelessWidget {
  Client_Draggable(this.gain);

  final int gain;

  @override
  Widget build(BuildContext context) {
    return Draggable<int>(
        data: gain,
        child: Client_Icon(gain),
        feedback : Client_Icon(gain),
        childWhenDragging: Container()
    );
    /*Material(
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
    );*/
  }
}

class Client_Icon extends StatelessWidget {
  Client_Icon(this.gain);

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

