<<<<<<< HEAD
import 'package:flame/util.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_prototype1/views/menuPrincipal.dart';

import 'ROgame.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Util flameUtil = Util();
  await flameUtil.fullScreen();
  await flameUtil.setOrientation(DeviceOrientation.landscapeLeft);

  ROgame game = ROgame();
  runApp(game.widget);
=======
import 'package:flutter/material.dart';
import 'package:flutter_prototype1/menuPrincipal.dart';

import 'package:flutter_prototype1/distributionService.dart';

void main() {
  runApp(
      MaterialApp(
        title: 'Notre application',
        home: Menu(),
      )
  );
>>>>>>> 853365e (Fusion Menu + Tuto Flame)
}



