import 'dart:ui';
import 'package:flame/sprite.dart';

import 'package:flutter_prototype1/ROgame.dart';
import 'package:flutter_prototype1/view.dart';

class DistriServButton {
  final ROgame game;
  Rect buttonRect;
  Sprite buttonSprite;

  DistriServButton(this.game){
    double tileH = game.tileHeightSize;
    double tileW = game.tileWidthSize;
    buttonRect = Rect.fromLTWH(tileW*10, tileH*2, tileW*5, tileH*2);
    buttonSprite = Sprite('boutons/boutonBleuDistributionService.png');
  }

  Rect getButtonRect(){
    return buttonRect;
  }

  void render(Canvas c){
    buttonSprite.renderRect(c,buttonRect);
  }

  void update(double t){}

  void onTapDown() {
    game.activeView = View.menuDistributionService;
  }
}