import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_prototype1/view/ScreenHome.dart';
import 'package:shared_preferences/shared_preferences.dart';

// creation de la classe widget ROgameUI est un StatefulWidget (widget pouvant changer d'etat)
class ROgameUI extends StatefulWidget {
  final ROgameUIState state = ROgameUIState();
  State<StatefulWidget> createState() => state;
}

class ROgameUIState extends State<ROgameUI> with WidgetsBindingObserver {

  SharedPreferences _storage; //creation d'un storage


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
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
    return ScreenHome();
  }
}
