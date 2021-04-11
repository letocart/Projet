import 'dart:ui';
import 'package:flame/sprite.dart';

import 'package:flutter_prototype1/ROgame.dart';

class Personnage {
  final ROgame game;
  Rect persoRect;
  Sprite persoSprite;

  Personnage(this.game){
    double tileH = game.tileHeightSize;
    double tileW = game.tileWidthSize;
    persoRect = Rect.fromLTWH(tileW, tileH*3, tileW*3, tileH*5);
    persoSprite = Sprite('professeur.png');
  }

  void render(Canvas c){
    persoSprite.renderRect(c,persoRect);
  }

  void update(double t){}
}