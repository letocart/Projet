import 'package:flutter/material.dart';
import 'package:or_game_app_v4/StorageUtil.dart';
import 'ORgameUI.dart';
import 'StorageUtil.dart';

/// ____________________________________________________________________
/// *         This is the first method called by the program
/// * It initiates values that will be needed during the whole app
/// ____________________________________________________________________

void main() async {
  WidgetsFlutterBinding.ensureInitialized();   // ensure having data Initialized
  await StorageUtil.getInstance();             // creating StorageUtil's instance with getInstance
  await StorageUtil.putString("lang", "EN");   // setting default language to English
  await StorageUtil.putString("isBuildingConstructionTutorialFirstVisited", "false");
  await StorageUtil.storeAllTexts();           // loading texts from json file and storing in storage
  ORgameUI gameUI = ORgameUI();                // creation d'un ROgameUI, gameUI un widget d'interface
  runApp(SharedPreference(gameUI));            // execution du widget MaterialApp contenant l'application
}

/// ___________________________________________________________________________________________
/// * This is the Widget that contains a state which choose the name and the color of  the app
/// ___________________________________________________________________________________________

class SharedPreference extends StatefulWidget {
  final ORgameUI gameUI;
  SharedPreference(this.gameUI); // Constructor

  @override
  _SharedPreferenceState createState() => _SharedPreferenceState(gameUI);
}

/// ______________________________________________________________
/// *   This is the state linked to the SharedPreference class
/// * The purpose of this class is to define the name of the app,
///       the default color and the default font of the app
/// ______________________________________________________________

class _SharedPreferenceState extends State<SharedPreference> {
  ORgameUI gameUI;
  _SharedPreferenceState(this.gameUI);

  // Building user interface
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Playing OR', // Name of the app
      theme: ThemeData(
        primarySwatch: Colors.blue, // Default color
        fontFamily: 'HVD', // Default font
      ),
      // This Scaffold is the first Widget of the app that will appear onto the phone screen
      home: Scaffold(
        body: Stack(
          fit: StackFit.expand, // Take the size of his parent, here the size of the whole screen
          children: <Widget>[
            Positioned.fill(
              child: gameUI, // Calling the rest of the app which is into ORgameUI.dart 
            ),
          ],
        ),
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}