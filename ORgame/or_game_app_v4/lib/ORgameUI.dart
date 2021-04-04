import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'view/ScreenHome.dart';
import 'dart:async' show Future;
import 'package:flutter/services.dart' show rootBundle;

// creation de la classe widget ROgameUI est un StatefulWidget (widget pouvant changer d'etat)
class ORgameUI extends StatefulWidget {
  final ORgameUIState state = ORgameUIState();
  State<StatefulWidget> createState() => state;
}

class ORgameUIState extends State<ORgameUI> with WidgetsBindingObserver {

  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
    return ScreenHome();
  }
}
