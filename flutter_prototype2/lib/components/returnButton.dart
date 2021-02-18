import 'dart:ui';
import 'package:flame/sprite.dart';

import 'package:flutter_prototype1/ROgame.dart';
import 'package:flutter_prototype1/view.dart';

class ReturnButton {
  final ROgame game;
  Rect buttonRect;
  Sprite buttonSprite;

  ReturnButton(this.game){
    double tileH = game.tileHeightSize;
    double tileW = game.tileWidthSize;
    buttonRect = Rect.fromLTWH(tileW*6, tileH*5, tileW*5, tileH*2);
    buttonSprite = Sprite("boutons/boutonRetour.png");
  }

  Rect getButtonRect(){
    return buttonRect;
  }

  void render(Canvas c){
    buttonSprite.renderRect(c,buttonRect);
  }

  void update(double t){}

  void onTapDown() {
    game.activeView = View.menuPrincipal;
  }
}