import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:shadow_training/widgets/punch-buttons.dart';
import 'package:shadow_training/shadow-training.dart';
import 'package:shared_preferences/shared_preferences.dart';
class RoGameUI extends StatefulWidget {
  final ROGameUIState state = ROgameUIState();

  State<StatefulWidget> createState() => state;
}


class ROgameUIState extends State<ROgameUI> with WidgetsBindingObserver {
  ROgame game;
  SharedPreferences _storage;

  View currentScreen = View.home;

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


  Widget DistriServButton() {
    return Ink(
      decoration: ShapeDecoration(
        shape: CircleBorder(),
      ),
      child: IconButton(
        color: Colors.white,
        icon: Icon(
          Icons.help_outline,
        ),
        onPressed: currentScreen == View.distributionService,
      ),
    );
  }
}
