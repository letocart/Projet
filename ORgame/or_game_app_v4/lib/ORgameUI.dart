import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'view/ScreenHome.dart';
import 'dart:async' show Future;
import 'package:flutter/services.dart' show rootBundle;

// The ORgameUI Class which helps to define the screen orientation through the whole application
class ORgameUI extends StatefulWidget {
  final ORgameUIState state = ORgameUIState();
  State<StatefulWidget> createState() => state;
}

//the ORgameUI State
class ORgameUIState extends State<ORgameUI> with WidgetsBindingObserver {

  // Building UI
  Widget build(BuildContext context) {
    // Setting the device orientation
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
    return ScreenHome();
  }
}
