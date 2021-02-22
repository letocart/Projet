import 'package:flame/util.dart';
import 'package:flame/flame.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_prototype1/ROgameUI.dart';

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
                                "boutons/menu.png",
                                "backgrounds/ciel.png"]);

  SharedPreferences storage = await SharedPreferences.getInstance();
  ROGameUI gameUI = ROGameUI();
  ROgame game = ROgame(gameUI);
  gameUI.state.storage = storage;
  gameUI.state.game = game;

  //runApp(game.widget);
  runApp(
    MaterialApp(
      title: 'ROgame',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'HVD',
      ),
      home: Scaffold(
        body: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            Positioned.fill(
              child: GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTapDown: game.onTapDown,
                child: game.widget,
              ),
            ),
            Positioned.fill(
              child: gameUI,
            ),
          ],
        ),
      ),
      debugShowCheckedModeBanner: false,
    ),
  );
}
