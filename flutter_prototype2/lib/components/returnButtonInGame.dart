import 'dart:ui';
import 'package:flame/sprite.dart';

import 'package:flutter_prototype1/ROgame.dart';
import 'package:flutter_prototype1/view.dart';

class ReturnButtonInGame {
  final ROgame game;
  Rect buttonRect;
  Sprite buttonSprite;

  ReturnButtonInGame(this.game){
    double tileH = game.tileHeightSize;
    double tileW = game.tileWidthSize;
    buttonRect = Rect.fromLTWH(tileW*11, tileH*0, tileW*5, tileH*2);
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
    if(game.activeView == View.distributionService) game.activeView = View.menuDistributionService;
    if(game.activeView == View.trajetBus) game.activeView = View.menuTrajetBus;
  }
}