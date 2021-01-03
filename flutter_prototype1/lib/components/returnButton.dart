import 'dart:ui';

import 'package:flutter_prototype1/ROgame.dart';
import 'package:flutter_prototype1/view.dart';

class ReturnButton {
  final ROgame game;
  Rect buttonRect;
  Paint buttonPaint; //à changer avec un sprite : Sprite buttonSprite;

  ReturnButton(this.game){
    double tile = game.tileHeightSize;
    buttonRect = Rect.fromLTWH(tile*12, tile*1, tile*3, tile*2);
    //à changer en buttonSprite = Sprite('lienSprite')
    buttonPaint = Paint();
    buttonPaint.color = Color(0xff009688);
  }

  Rect getButtonRect(){
    return buttonRect;
  }

  void render(Canvas c){
    c.drawRect(buttonRect, buttonPaint); //à changer en : buttonSprite.renderRect(c,buttonRect);
  }

  void update(double t){}

  void onTapDown() {
    game.activeView = View.menuPrincipal;
  }
}