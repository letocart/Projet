import 'dart:ui';

import 'package:flutter_prototype1/ROgame.dart';
import 'package:flutter_prototype1/view.dart';

class TrajetBusButton {
  final ROgame game;
  Rect buttonRect;
  Paint buttonPaint; //à changer avec un sprite : Sprite buttonSprite;

  TrajetBusButton(this.game){
    double tileH = game.tileHeightSize;
    double tileW = game.tileWidthSize;
    buttonRect = Rect.fromLTWH(tileW*11, tileH*5, tileW*3, tileH*2);
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
    game.activeView = View.menuTrajetBus;
  }
}