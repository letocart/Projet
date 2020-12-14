import 'package:flutter/material.dart';

class Style{

  static final ThemeData themePrincipal = ThemeData(
    primarySwatch: Colors.teal,
    scaffoldBackgroundColor: Colors.white70,
    visualDensity: VisualDensity.adaptivePlatformDensity,
  );

  static final ThemeData themeTrajetBus = ThemeData(
    primarySwatch: Colors.teal,
    scaffoldBackgroundColor: Colors.amberAccent,
    visualDensity: VisualDensity.adaptivePlatformDensity,
  );

  static final ThemeData themeDistributionService = ThemeData(
    primarySwatch: Colors.teal,
    scaffoldBackgroundColor: Colors.blueGrey,
    visualDensity: VisualDensity.adaptivePlatformDensity,
  );

  static final ButtonStyle buttonText = TextButton.styleFrom
    (
    primary: Colors.white,
    backgroundColor: Colors.teal,
    onSurface: Colors.grey,
  );

}