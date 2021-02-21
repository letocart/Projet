import 'dart:ui';
import 'package:flame/sprite.dart';

import 'package:flutter_prototype1/ROgame.dart';
import 'package:flutter_prototype1/components/returnButtonInGame.dart';

class MenuButton {
  final ROgame game;
  Rect buttonRect;
  Sprite buttonSprite;
  ReturnButtonInGame returnButtonInGame;
  bool isHandle = false;

  MenuButton(this.game){
    double tileH = game.tileHeightSize;
    double tileW = game.tileWidthSize;
    buttonRect = Rect.fromLTWH(tileW*14.15, tileH*-0.3, tileW*2, tileH*2);
    buttonSprite = Sprite("boutons/menu.png");
    returnButtonInGame = ReturnButtonInGame(game);
  }

  Rect getButtonRect(){
    return buttonRect;
  }

  void reinitiateIsHandle()
  {
    isHandle = false;
  }

  void render(Canvas c){
    buttonSprite.renderRect(c,buttonRect);
    if(isHandle)
      returnButtonInGame.render(c);
  }

  void update(double t){}

  void onTapDown() {
    if(!isHandle) isHandle = true;
    else isHandle = false;
  }
}