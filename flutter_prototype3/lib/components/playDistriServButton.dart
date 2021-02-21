import 'dart:ui';
import 'package:flame/sprite.dart';

import 'package:flutter_prototype1/ROgame.dart';
import 'package:flutter_prototype1/view.dart';

class PlayDistriServButton {
  final ROgame game;
  Rect buttonRect;
  Sprite buttonSprite;

  PlayDistriServButton(this.game){
    double tileH = game.tileHeightSize;
    double tileW = game.tileWidthSize;
    buttonRect = Rect.fromLTWH(tileW*6, tileH*3, tileW*5, tileH*2);
    buttonSprite = Sprite('boutons/boutonJouer.png');
  }

  Rect getButtonRect(){
    return buttonRect;
  }

  void render(Canvas c){
    buttonSprite.renderRect(c,buttonRect);
  }

  void update(double t){}

  void onTapDown() {
    game.activeView = View.distributionService;
  }
}