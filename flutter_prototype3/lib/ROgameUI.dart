import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_prototype1/ROgame.dart';
import 'package:flutter_prototype1/view.dart';

class ROGameUI extends StatefulWidget {
  final ROgameUIState state = ROgameUIState();

  State<StatefulWidget> createState() => state;
}

class ROgameUIState extends State<ROGameUI> with WidgetsBindingObserver {
  ROgame game;
  SharedPreferences _storage;

  View currentScreen = View.menuPrincipal;

  int score = 0;
  int highScore = 0;

  SharedPreferences get storage => _storage;
  set storage(SharedPreferences value) {
    _storage = value;
    highScore = storage.getInt('high-score') ?? 0;
    if (mounted) {
      update();
    }
  }


  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  void update() {
    setState(() {});
  }

  Widget spacer({int size}) {
    return Expanded(
      flex: size ?? 100,
      child: Center(),
    );
  }

  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children : [
        TextButton(
            onPressed: () {
              print("Jeu n°1 pressed");
            },
            style : TextButton.styleFrom
              (
              primary: Colors.white,
              backgroundColor: Colors.teal,
              onSurface: Colors.grey,
              ),
            child: Text('Jeu n°1')
        ),
        TextButton(
            onPressed: (){
              print('Jeu 2 pressed');
            },
            style : TextButton.styleFrom
              (
              primary: Colors.white,
              backgroundColor: Colors.teal,
              onSurface: Colors.grey,
            ),
            child: Text('Jeu n°2')
        ),
      ],
    );
  }
}
