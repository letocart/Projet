import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_prototype1/style.dart';
import 'package:flutter_prototype1/views/distributionService.dart';
import 'package:flutter_prototype1/views/trajetBus.dart';

import '../ROgame.dart';

class Menu {
  final ROgame game;

  Rect bgRect;
  Paint bgPaint; //à changer avec un sprite : Sprite bgSprite;

  Menu(this.game){
    bgRect = Rect.fromLTWH(0, 0, game.screenSize.width, game.screenSize.height);
    //à changer en : bgSprite = Sprite('lienSprite');
    bgPaint = Paint();
    bgPaint.color = Color(0xff9e9e9e);
  }

  void render(Canvas c){
    c.drawRect(bgRect, bgPaint); //à changer en : bgSprite.renderRect(c,bgRect);
  }

  void update(double t) {}

}

/*
class Menu extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
    return MaterialApp(
      title: 'Jouons à la RO',
      theme: Style.themePrincipal,
      home: Scaffold(
        appBar: AppBar(
          title: Text('Jouons à la RO'),
        ),
        body: Center(
          child : Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children : [
              Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children : [Text('Je suis un personnage')]
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children : [
                  TextButton(
                      onPressed: () async {
                        print("Jeu n°1 pressed");
                        await Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => MenuDistributionService())
                        );
                      },
                      style : Style.buttonText,
                      child: Text('Jeu n°1')
                  ),
                  TextButton(
                      onPressed: () async{
                        print('Jeu 2 pressed');
                        await Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => MenuTrajetBus())
                        );
                      },
                      style : Style.buttonText,
                      child: Text('Jeu n°2')
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
*/
