import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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