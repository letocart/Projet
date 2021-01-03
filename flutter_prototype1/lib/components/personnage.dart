import 'dart:ui';

import 'package:flutter_prototype1/ROgame.dart';

class Personnage {
  final ROgame game;
  Rect persoRect;
  Paint persoPaint; //à changer avec un sprite : Sprite persoSprite;

  Personnage(this.game){
    double tileH = game.tileHeightSize;
    double tileW = game.tileWidthSize;
    persoRect = Rect.fromLTWH(tileW, tileH*3, tileW*3, tileH*5);
    //à changer en persoSprite = Sprite('lienSprite');
    persoPaint = Paint();
    persoPaint.color = Color(0xffff5733);
  }

  void render(Canvas c){
    c.drawRect(persoRect, persoPaint); //à changer en : persoSprite.renderRect(c,bgRect);
  }

  void update(double t){}
}