import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_prototype1/style.dart';
import 'package:flame/util.dart';

import 'package:flame/game.dart';
import 'dart:ui';

import 'package:flame/util.dart';
import 'package:flutter/services.dart';
import 'package:flutter/gestures.dart';

class MenuTrajetBus extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
    return MaterialApp(
        title: "Jeu du voyageur de commerce",
        theme: Style.themeTrajetBus,
        home: Scaffold(
            appBar: AppBar(
              title: Text("Jeu du voyageur de commerce"),
            ),
            body: Center(
                child : Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children : [
                    Text("Jeu n°2"),
                    TextButton(
                        onPressed: (){
                          print('Play pressed');
                          init();
                          /*Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => TrajetBus())
                          );*/
                        },
                        style : Style.buttonText,
                        child: Text('Jouer')
                    ),
                    TextButton(
                        onPressed: (){
                          print('Return pressed');
                          Navigator.pop(context);
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

void init() async
{
  WidgetsFlutterBinding.ensureInitialized();
  Util flameUtil = Util();
  await flameUtil.fullScreen();
  await flameUtil.setOrientation(DeviceOrientation.landscapeLeft);


  TestJeu2 jeu = TestJeu2();
  TapGestureRecognizer tapper = TapGestureRecognizer();
  tapper.onTapDown = jeu.onTapDown;
  runApp(jeu.widget);
  flameUtil.addGestureRecognizer(tapper);
}

class TrajetBus extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
    final test2 = TestJeu2();
    return MaterialApp(
        title: "Jeu du voyageur de commerce",
        theme: Style.themeTrajetBus,
        home: Scaffold(
            appBar: AppBar(
              title: Text("Jeu du voyageur de commerce"),
            ),
            body: Center(
                child :  Stack(
                    children : [
                      test2.widget,
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
    canvas.drawRect(Offset(100, 100) & Size(200, 100), paint1);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}

class TestJeu2 extends Game {
  Size screenSize;
  bool isGreen = false;
  @override
  void render(Canvas canvas) {
    Rect bgRect = Rect.fromLTWH(0, 0, screenSize.width, screenSize.height);
    Paint bgPaint = Paint();
    bgPaint.color = Color(0xffff5733);
    canvas.drawRect(bgRect, bgPaint);

    double screenCenterX = screenSize.width / 2;
    double screenCenterY = screenSize.height / 2;
    Rect boxRect = Rect.fromLTWH(
        screenCenterX - 75,
        screenCenterY - 75,
        150,
        150
    );
    Paint boxPaint = Paint();
    if (isGreen) {
      boxPaint.color = Color(0xff00ff00);
    } else {
      boxPaint.color = Color(0xffffffff);
    }
    canvas.drawRect(boxRect, boxPaint);
  }

  @override
  void update(double t) {
    // TODO: implement update
  }

  void resize(Size size) {
    screenSize = size;
    super.resize(size);
  }

  void onTapDown(TapDownDetails d) {
    double screenCenterX = screenSize.width / 2;
    double screenCenterY = screenSize.height / 2;
    if (d.globalPosition.dx >= screenCenterX - 75
        && d.globalPosition.dx <= screenCenterX + 75
        && d.globalPosition.dy >= screenCenterY - 75
        && d.globalPosition.dy <= screenCenterY + 75
    ) {
      if(isGreen) isGreen = false;
      else isGreen = true;
    }
  }
}