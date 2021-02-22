import 'package:flame/sprite.dart';
import 'package:flutter/material.dart';
import 'package:flutter_prototype1/ROgame.dart';

import 'dart:ui';

class EcranTitre {
  final ROgame game;

  Rect bgRect;
  Sprite bgSprite;

  EcranTitre(this.game){
    bgRect = Rect.fromLTWH(0, 0, game.screenSize.width, game.screenSize.height);
    bgSprite = Sprite('backgrounds/ciel.png');
  }

  void render(Canvas c){
    bgSprite.renderRect(c,bgRect);
  }

  void update(double t) {}

}