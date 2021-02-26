// imports
import 'package:flame/util.dart';
import 'package:flame/flame.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_prototype1/test/tests_unitaires.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_prototype1/ROgameUI.dart';

import 'ROgame.dart';

// main async pour flame
void main() async {

  // tests unitaires sur les models
  assert_DSM();
  assert_DSD();
  assert_DSC();

  // initialisation de flame
  WidgetsFlutterBinding.ensureInitialized();
  Util flameUtil = Util();

  // configuration de l'orientation de l'ecran
  await flameUtil.fullScreen();
  await flameUtil.setOrientation(DeviceOrientation.landscapeLeft);

  // chargement de toutes les images dans flame
  /*
  Flame.images.loadAll(<String>['professeur.png',
                                "boutons/boutonBleuDistributionService.png",
                                "boutons/boutonBleuTrajetBus.png",
                                "boutons/boutonJouer.png",
                                "boutons/boutonRetour.png",
                                "boutons/menu.png",
                                "backgrounds/city2.jpg",
                                "backgrounds/ciel.png",]);*/

  // creation d'une variable de stockage, encore non utilisee
  SharedPreferences storage = await SharedPreferences.getInstance();

  // creation d'un ROgameUI, gameUI un widget d'interface
  ROgameUI gameUI = ROgameUI();
  // creation d'un ROgame, objet flame
  ROgame game = ROgame(gameUI);

  // affectation du storage et du jeu a l'interface
  gameUI.state.storage = storage;
  gameUI.state.game = game;

  // execution du widget MaterialApp contenant l'application
  //runApp(game.widget);
  runApp(
    MaterialApp(
      title: 'ROgame',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'HVD',
      ),
      home: Scaffold( //home: ce qui va s'afficher
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
