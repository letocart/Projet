import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_prototype1/ROgame.dart';
import 'package:flutter_prototype1/view.dart';
import 'package:flutter_prototype1/style.dart';

class ROGameUI extends StatefulWidget {
  final ROgameUIState state = ROgameUIState();

  State<StatefulWidget> createState() => state;
}

class ROgameUIState extends State<ROGameUI> with WidgetsBindingObserver {
  ROgame game;
  SharedPreferences _storage;

  View currentScreen = View.ecranTitre;

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

  Widget buildScreenMenuPrincipal() {
    return Center(
        child : Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children : [
            Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children : [Text('Je suis un personnage')]
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children : [
                TextButton(
                    onPressed: () {
                      print("Jeu n°1 pressed");
                    },
                    style : Style.buttonText,
                    child: Text('Jeu n°1')
                ),
                TextButton(
                    onPressed: (){
                      print('Jeu 2 pressed');
                    },
                    style : Style.buttonText,
                    child: Text('Jeu n°2')
                ),
              ],
            ),
          ],
        ),
      );
  }

  Widget buildScreenHome() {
    return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children : [
                    Text('Welcome to RO Game'),
                    TextButton(
                        onPressed: () {
                          print("Start pressed");
                          currentScreen = View.ecranTitre;
                          game.init();
                          update();
                          /*
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => buildScreenMenuPrincipal())
                          );*/
                        },
                        style : Style.buttonText,
                        child: Text('Start Game')
                    ),
                ],
              );
  }

  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Expanded(
          child: IndexedStack(
            sizing: StackFit.expand,
            children: <Widget>[
              buildScreenHome(),
              buildScreenMenuPrincipal(),
            ],
            index: currentScreen.index,
          ),
        ),
      ],
    );
  }
}
