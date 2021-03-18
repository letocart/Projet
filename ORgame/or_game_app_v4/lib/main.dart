// imports
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'ROgameUI.dart';

import 'DistributionServices/test/DistributionServicesTestsUnitaires.dart';

// main async pour flame
void main() async {

  // tests unitaires sur les models
  assert_DSM();
  assert_DSD();
  assert_DSC();

  WidgetsFlutterBinding.ensureInitialized();


  // creation d'une variable de stockage, encore non utilisee
  SharedPreferences storage = await SharedPreferences.getInstance();

  // creation d'un ROgameUI, gameUI un widget d'interface
  ROgameUI gameUI = ROgameUI();

  // affectation du storage et du jeu a l'interface
  gameUI.state.storage = storage;

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
              child: gameUI,
            ),
          ],
        ),
      ),
      debugShowCheckedModeBanner: false,
    ),
  );
}
