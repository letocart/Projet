import 'package:flame/util.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_prototype1/views/menuPrincipal.dart';
import 'package:flame/flame.dart';

import 'ROgame.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Util flameUtil = Util();
  await flameUtil.fullScreen();
  await flameUtil.setOrientation(DeviceOrientation.landscapeLeft);

  Flame.images.loadAll(<String>['professeur.png',
                                "boutons/boutonBleuDistributionService.png",
                                "boutons/boutonBleuTrajetBus.png",
                                "boutons/boutonJouer.png",
                                "boutons/boutonRetour.png",
                                "boutons/menu.png"]);

  ROgame game = ROgame();
  runApp(game.widget);
}



