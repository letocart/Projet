import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../StorageUtil.dart';
import 'PopUp.dart';

/// __________________________________________________________________
/// This class contains several Icon that appear on every screen :
/// * The UK flag icon
/// * The French flag icon
/// * The manual icon
///
/// This class manage the actions linked to those icon
/// (change the language or make a dialog box appear)
/// __________________________________________________________________

class IconWidget extends StatefulWidget {

  State parent; //the parent State Widget
  final Axis direction;

  IconWidget(this.direction,this.parent); // constructor

  @override
  State<StatefulWidget> createState() => IconWidgetState(direction,parent);
}

/// ____________________________________________________________
///    This the state linked to the class IconWidget
/// ____________________________________________________________

class IconWidgetState extends State<IconWidget>{

  State parent; //the parent State Widget
  final Axis direction;

  IconWidgetState(this.direction,this.parent); // Constructor

  // overriding build method
  @override
  Widget build(BuildContext context) {
    // if the axis is horizontal or vertical there are some display differences
    // which implies a bit of code duplication below
    if(direction==Axis.horizontal) {
      return buildHorizontalIcons();
    }
    else if(direction==Axis.vertical) {
      return buildVerticalIcons();
    }
    else // this case is not supposed to happen
    {
      return Container(
          width: 50,
          height: 50,
          color: Colors.red,
          child : Text("Direction not supported")
      );
    }
  }


    Widget buildHorizontalIcons(){
    return Positioned(
        top: 0.0,
        left: 0.0,
        child: Row(
          children: [
            // UK flag
            Material(
              color: Colors.transparent, // The color of rectangle around the icon
              child: Ink(
                  decoration: const ShapeDecoration(
                      color: Colors.transparent, // The color of the circle around the icon
                      shape: CircleBorder()),
                  child: IconButton(
                    icon: Image.asset('assets/images/icon/uk.png'),
                    onPressed: () async {
                      await StorageUtil.putString("lang",'EN'); // updating Language Storage
                      this.parent.setState(() {});              // refreshing parent widget
                    },
                  )
              ),
            ),
            // French flag
            Material(
              color: Colors.transparent, // The color of rectangle around the icon
              child: Ink(
                  decoration: const ShapeDecoration(
                      color: Colors.transparent, // The color of the circle around the icon
                      shape: CircleBorder()),
                  child: IconButton(
                    icon: Image.asset('assets/images/icon/fr.png'),
                    onPressed: () async {
                      await StorageUtil.putString("lang",'FR'); // updating Language Storage
                      this.parent.setState(() {});
                    },
                  )
              ),
            ),
              // manual icon
              Material(
              color: Colors.transparent, // The color of rectangle around the icon
              child: Ink(
                  decoration: const ShapeDecoration(
                      color: Colors.transparent, // The color of the circle around the icon
                      shape: CircleBorder()),
                  child: IconButton(
                    icon: Image.asset('assets/images/icon/manual.png'),
                    onPressed: () {
                      // This is the pop up that appears when we pressed the manual icon
                      showDialog(
                          context: context,
                          builder: (BuildContext context) =>
                              buildPopUpRule() // This is defined lower
                      );
                    },
                  )
              ),
            )
          ],
        )
    );
  }
  Widget buildVerticalIcons(){
    return Positioned(
        top: 0.0,
        left: 0.0,
        child: Column(
          children: [
            Material(
              color : Colors.transparent, // The color of rectangle around the icon
              child: Ink(
                  decoration: const ShapeDecoration(
                      shape: CircleBorder()
                  ),
                  // UK flag
                  child : IconButton(
                    padding: EdgeInsets.only(top : 10, left : 10),
                    constraints: BoxConstraints(),
                    icon: Image.asset('assets/images/icon/uk.png'),
                    onPressed: () async {
                      await StorageUtil.putString("lang",'EN'); // updating Storage
                      this.parent.setState(() {});              // refreshing parent widget
                    },
                  )
              ),
            ),
            // French flag
            Material(
              color : Colors.transparent,
              child: Ink(
                  decoration: const ShapeDecoration(
                      color: Colors.transparent,
                      shape: CircleBorder()),
                  child : IconButton(
                    padding: EdgeInsets.only(left : 10),
                    constraints: BoxConstraints(),
                    icon: Image.asset('assets/images/icon/fr.png'),
                    onPressed: () async {
                      await StorageUtil.putString("lang",'FR'); // updating language Storage
                      this.parent.setState(() {}); // Refreshing display
                    },
                  )
              ),
            ),
            // Manual icon
            Material(
              color : Colors.transparent,
              child: Ink(
                  decoration: const ShapeDecoration(
                      color: Colors.transparent,
                      shape: CircleBorder()),
                  child : IconButton(
                    padding: EdgeInsets.only(top : 10, left : 10),
                    constraints: BoxConstraints(),
                    icon: Image.asset('assets/images/icon/manual.png'),
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (BuildContext context) =>
                              buildPopUpRule()
                      );
                      this.parent.setState(() {});
                    },
                  )
              ),
            )
          ],
        )
    );
  }

  // Build the Popup according to which widget we are in
  // it implies that a certain format to name the views is respected
  Widget buildPopUpRule(){
    String title;
    List<String> listOfTexts;

    if(this.parent.runtimeType.toString().contains("BuildingConstruction")) { // if we are in a BuildingConstruction game's view
      return BuildingConstructionRulePopUp();
    }else{  // otherwise
      return GeneralRulePopUp();
    }
  }
}


