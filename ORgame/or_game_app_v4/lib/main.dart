// imports
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:or_game_app_v4/StorageUtil.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'ORgameUI.dart';
import 'StorageUtil.dart';
import 'BusLine/test/BusLineUnitTests.dart';
import 'BuildingConstruction/test/BuildingConstructionUnitTests.dart';

// main async pour flame
void main() async {

  // Unit tests on model, controller and data
  // for Building Construction
  //assertBCM();
  //assertBCD();
  //assertBCC();
  // for Bus Line : there is a problem within the assertBLD two list are similar but the test show the opposite
  //assertBLM();
  //assertBLD();
  //assertBLC();

  // ensure having data Initialized
  WidgetsFlutterBinding.ensureInitialized();
  // creating StorageUtil's instance with getInstance
  await StorageUtil.getInstance();
  // setting default language to English
  await StorageUtil.putString("lang", "EN");
  //print("I am the Main Language: "+StorageUtil.getString("lang"));

  // loading texts from json file and storing in storage
  await StorageUtil.storeAllTexts();
  //print("I am a test Text: "+StorageUtil.getString("welcomeTextEN"));

  // creation d'un ROgameUI, gameUI un widget d'interface
  ORgameUI gameUI = ORgameUI();

  // affectation du storage et du jeu a l'interface
  //gameUI.state.storage = storage;

  // execution du widget MaterialApp contenant l'application

  runApp(SharedPreference(gameUI));

}

class SharedPreference extends StatefulWidget {

  final ORgameUI gameUI;
  SharedPreference(this.gameUI);

  @override
  _SharedPreferenceState createState() => _SharedPreferenceState(gameUI);
}



class _SharedPreferenceState extends State<SharedPreference> {
  //String savedString = "Here will Preference Value";
  ORgameUI gameUI;

  _SharedPreferenceState(this.gameUI);

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      title: 'Playing OR',
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
    );
  }
}