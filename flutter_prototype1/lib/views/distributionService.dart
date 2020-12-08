import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_prototype1/ROgame.dart';
import 'package:flutter_prototype1/style.dart';

import 'package:flame/game.dart';
import 'dart:ui';

class DistributionService {
  final ROgame game;

  Rect bgRect;
  Paint bgPaint; //à changer avec un sprite : Sprite bgSprite;

  DistributionService(this.game){
    bgRect = Rect.fromLTWH(0, 0, game.screenSize.width, game.screenSize.height);
    //à changer en : bgSprite = Sprite('lienSprite');
    bgPaint = Paint();
    bgPaint.color = Color(0xff607D8D);
  }

  void render(Canvas c){
    c.drawRect(bgRect, bgPaint); //à changer en : bgSprite.renderRect(c,bgRect);
  }

  void update(double t) {}

}

/*
class MenuDistributionService extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
    return MaterialApp(
        title: "Jeu d'ordonnancement à n machine",
        theme: Style.themeDistributionService,
        home: Scaffold(
            appBar: AppBar(
              title: Text("Jeu d'ordonnancement à n machine"),
            ),
            body: Center(
                child : Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children : [
                    Text("Jeu n°1"),
                    TextButton(
                        onPressed: () async {
                          print('Play pressed');
                          await Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => DistributionService())
                          );
                        },
                        style : Style.buttonText,
                        child: Text('Jouer')
                    ),
                    TextButton(
                        onPressed: () async {
                          print('Return pressed');
                          await Navigator.pop(context);
                        },
                        style : Style.buttonText,
                        child: Text('Retour')
                    ),
                  ],
                )
            )
        )
    );
  }
}


class DistributionService extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
    return MaterialApp(
        title: "Jeu d'ordonnancement à n machine",
        theme: Style.themeDistributionService,
        home: Scaffold(
            appBar: AppBar(
              title: Text("Jeu d'ordonnancement à n machine"),
            ),
            body: Center(
                child :  Stack(
                    children : [
                      Positioned(
                          left: 0,
                          top: 0,
                          child: Container(
                              child: Draggable(
                                  child : Container(
                                    width: 400,
                                    height: 400,
                                    child: CustomPaint(
                                      painter: OpenPainter(),
                                    ),
                                  ),
                                  feedback : Container(
                                    width: 400,
                                    height: 400,
                                    child: CustomPaint(
                                      painter: OpenPainter(),
                                    ),
                                  ),
                                  childWhenDragging: Container()
                              )
                          )
                      ),
                      Positioned(
                          right: 0,
                          child:
                          TextButton(
                              onPressed: ()
                              {
                                print('Return pressed');
                                Navigator.pop(context);
                              },
                              style : Style.buttonText,
                              child: Text('Retour')
                          )
                      )
                    ]
                )
            )
        )
    );
  }
}

class OpenPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var paint1 = Paint()
      ..color = Color(0xffAC33FF)
      ..style = PaintingStyle.fill;
    //a rectangle
    canvas.drawRect(Offset(250, 100) & Size(200, 100), paint1);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}

 */