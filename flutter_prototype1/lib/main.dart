import 'package:flutter/material.dart';
import 'package:flutter_prototype1/menuPrincipal.dart';

import 'package:flame/util.dart';
import 'package:flutter/services.dart';
import 'package:flutter/gestures.dart';

import 'package:flutter_prototype1/distributionService.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  Util flameUtil = Util();
  await flameUtil.fullScreen();
  await flameUtil.setOrientation(DeviceOrientation.landscapeLeft);


  TestJeu1 jeu = TestJeu1();
  TapGestureRecognizer tapper = TapGestureRecognizer();
  tapper.onTapDown = jeu.onTapDown;
  runApp(jeu.widget);
  flameUtil.addGestureRecognizer(tapper);
}



