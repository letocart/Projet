import 'package:flutter/material.dart';

// styles predifinies d'affichage
class Style{

  static final ThemeData themePrincipal = ThemeData(
    primarySwatch: Colors.teal,
    scaffoldBackgroundColor: Colors.white70,
    visualDensity: VisualDensity.adaptivePlatformDensity,
  );

  static final ButtonStyle buttonText = TextButton.styleFrom(
    textStyle : TextStyle(color:Colors.white),
    backgroundColor: Colors.orange,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(30.0),
    ),
  );

  static final ButtonStyle returnButtonText = TextButton.styleFrom(
    textStyle : TextStyle(color:Colors.white),
    backgroundColor: Colors.blue,
  );

  static final ButtonStyle exitButtonText = TextButton.styleFrom(
    textStyle : TextStyle(color:Colors.black),
    backgroundColor: Colors.white,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(30.0),
    ),
  );
}