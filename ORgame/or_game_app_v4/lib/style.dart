import 'package:flutter/material.dart';

/// _____________________________________________________________________
/// This class define some styles (colors, fonts, ...) useful for button
/// There is three button styles :
/// * buttonText which is used for the buttons into menus
/// * returnButtonText which is used for the return buttons
/// * exitButtonText which is used into the welcome menu
/// _____________________________________________________________________

class Style{

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