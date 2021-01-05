import 'dart:ui';

import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flame/gestures.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_prototype1/components/distriServButton.dart';
import 'package:flutter_prototype1/components/personnage.dart';
import 'package:flutter_prototype1/components/playDistriServButton.dart';
import 'package:flutter_prototype1/components/playTrajetBus.dart';
import 'package:flutter_prototype1/components/returnButton.dart';
import 'package:flutter_prototype1/components/trajetBusButton.dart';
import 'package:flutter_prototype1/view.dart';
import 'package:flutter_prototype1/views/distributionService.dart';
import 'package:flutter_prototype1/views/menuPrincipal.dart';
import 'package:flutter_prototype1/views/trajetBus.dart';

class ROgame extends Game with TapDetector{
  Size screenSize;
  double tileHeightSize;
  double tileWidthSize;

  View activeView = View.menuPrincipal;

  Menu menu;
  DistributionService distributionService;
  TrajetBus trajetBus;

  Personnage personnage;
  DistriServButton distriServButton;
  PlayDistriServButton playDistriServButton;
  TrajetBusButton trajetBusButton;
  PlayTrajetBusButton playTrajetBusButton;
  ReturnButton returnButton;

  ROgame() {
    init();
  }

  void init() async {
    resize(await Flame.util.initialDimensions());

    returnButton = ReturnButton(this);

    //view : menuPrincipal
    menu = Menu(this);
    personnage = Personnage(this);
    distriServButton = DistriServButton(this);
    trajetBusButton = TrajetBusButton(this);

    //view : menu distributionService
    distributionService = DistributionService(this);
    playDistriServButton = PlayDistriServButton(this);

    //view : menu trajetBus
    trajetBus = TrajetBus(this);
    playTrajetBusButton = PlayTrajetBusButton(this);
  }

  @override
  void render(Canvas canvas) {
    if(activeView == View.menuPrincipal) {
      menu.render(canvas);
      personnage.render(canvas);
      distriServButton.render(canvas);
      trajetBusButton.render(canvas);
    }

    if(activeView == View.menuDistributionService){
      distributionService.render(canvas);
      playDistriServButton.render(canvas);
      returnButton.render(canvas);
    }

    if(activeView == View.distributionService){
      distributionService.render(canvas);
      returnButton.render(canvas);
    }

    if(activeView == View.menuTrajetBus){
      trajetBus.render(canvas);
      playTrajetBusButton.render(canvas);
      returnButton.render(canvas);
    }

    if(activeView == View.trajetBus){
      trajetBus.render(canvas);
      returnButton.render(canvas);
    }
  }

  @override
  void update(double t) {
    // TODO: implement update
  }

  @override
  void resize(Size size) {
    screenSize = size;
    tileHeightSize = screenSize.height/9;
    tileWidthSize = screenSize.width/16;
  }


  @override
  void onTapDown(TapDownDetails details){
    bool isHandled = false;

    if(!isHandled && distriServButton.getButtonRect().contains(details.globalPosition)){
      if(activeView == View.menuPrincipal){
        distriServButton.onTapDown();
        isHandled = true;
      }
    }

    if(!isHandled && trajetBusButton.getButtonRect().contains(details.globalPosition)){
      if(activeView == View.menuPrincipal){
        trajetBusButton.onTapDown();
        isHandled = true;
      }
    }

    if(!isHandled && playDistriServButton.getButtonRect().contains(details.globalPosition)){
      if(activeView == View.menuDistributionService){
        playDistriServButton.onTapDown();
        isHandled = true;
      }
    }

    if(!isHandled && playTrajetBusButton.getButtonRect().contains(details.globalPosition)){
      if(activeView == View.menuTrajetBus){
        playTrajetBusButton.onTapDown();
        isHandled = true;
      }
    }

    if(!isHandled && returnButton.getButtonRect().contains(details.globalPosition)){
      if(activeView == View.menuTrajetBus ||
          activeView == View.trajetBus ||
          activeView == View.menuDistributionService ||
          activeView == View.distributionService){
        returnButton.onTapDown();
        isHandled = true;
      }
    }

  }

}