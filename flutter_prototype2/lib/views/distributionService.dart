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