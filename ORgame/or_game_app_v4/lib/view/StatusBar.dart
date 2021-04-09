import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// Container to add a padding at the top of the screen for the phone's status bar
class StatusBar extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Container(
      // get status bar size of the phone
        height : MediaQuery.of(context).padding.top,
        width : MediaQuery.of(context).size.width,
        color : Colors.black
    );
  }
}
