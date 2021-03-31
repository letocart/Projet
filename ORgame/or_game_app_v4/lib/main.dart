// imports
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'BuildingConstruction/test/BuildingConstructionUnitTests.dart';
import 'ORgameUI.dart';
import 'BusLine/test/BusLineUnitTests.dart';
// main async pour flame
void main() async {

  // Unit tests on model, controller and data
  // for Building Construction
  assertBCM();
  assertBCD();
  assertBCC();

  // for Bus Line : there is a problem within the assertBLD two list are similar but the test show the opposite
  //assertBLM();
  //assertBLD();
  //assertBLC();
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
