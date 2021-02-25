import 'package:flutter/material.dart';
import 'package:flutter_prototype1/widgets/ScreenMenuPrincipal.dart';
import 'package:flutter_prototype1/widgets/ScreenHome.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_prototype1/ROgame.dart';
import 'package:flutter_prototype1/view.dart';
import 'package:flutter_prototype1/style.dart';

// creation de la classe widget ROgameUI est un StatefulWidget (widget pouvant changer d'etat)
class ROgameUI extends StatefulWidget {
  final ROgameUIState state = ROgameUIState();
  State<StatefulWidget> createState() => state;
}

class ROgameUIState extends State<ROgameUI> with WidgetsBindingObserver {

  ROgame game;  //creation d'un game
  SharedPreferences _storage; //creation d'un storage

  View currentScreen = View.ecranTitre; //creation d'une View, creant la vue d'ecran titre

  /* initialisation et recuperation de donnees stockees
  int score = 0;
  int highScore = 0;

*/
  SharedPreferences get storage => _storage;

  set storage(SharedPreferences value) {
    _storage = value;
    //highScore = storage.getInt('high-score') ?? 0;
    if (mounted) {
      update();
    }
  }


/*
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }
*/
  void update() {
    setState(() {});
  }
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Expanded(
          child: IndexedStack(
            sizing: StackFit.expand,
            children: <Widget>[
              ScreenHome(),
              ScreenMenuPrincipal(),
            ],
            index: currentScreen.index, //affichage de l'ecran selon l'index
          ),
        ),
      ],
    );
  }
}