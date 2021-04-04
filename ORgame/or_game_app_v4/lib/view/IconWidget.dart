import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../language.dart';

class IconWidget extends StatefulWidget {
  IconWidget(this.direction, this.lang);

  final Axis direction;
  Language lang;

  @override
  State<StatefulWidget> createState() => IconWidgetState(direction, lang);
}

class IconWidgetState extends State<IconWidget>{
  IconWidgetState(this.direction, this.lang);

  final Axis direction;
  Language lang;

  @override
  Widget build(BuildContext context) {
    if(direction==Axis.horizontal) {
      return Positioned(
          top: 0.0,
          left: 0.0,
          child: Row(
            children: [
              Material(
                color: Colors.transparent,
                child: Ink(
                    decoration: const ShapeDecoration(
                        color: Colors.transparent,
                        shape: CircleBorder()),
                    child: IconButton(
                      icon: Image.asset('assets/images/icon/uk.png'),
                      onPressed: () {
                        print("Langue actuelle : ${lang.getLanguage()}");
                        print("UK flag pressed");
                        setState(() {
                          this.lang.setLanguage('English');

                        });
                        print("Langue actuelle : ${lang.getLanguage()}");
                      },
                    )
                ),
              ),
              Material(
                color: Colors.transparent,
                child: Ink(
                    decoration: const ShapeDecoration(
                        color: Colors.transparent,
                        shape: CircleBorder()),
                    child: IconButton(
                      icon: Image.asset('assets/images/icon/fr.png'),
                      onPressed: () {
                        print("Langue actuelle : ${lang.getLanguage()}");
                        print("French flag pressed");
                        setState(() {
                          this.lang.setLanguage('French');
                        });
                        print("Langue actuelle : ${lang.getLanguage()}");
                      },
                    )
                ),
              ),
              Material(
                color: Colors.transparent,
                child: Ink(
                    decoration: const ShapeDecoration(
                        color: Colors.transparent,
                        shape: CircleBorder()),
                    child: IconButton(
                      icon: Image.asset('assets/images/icon/manual.png'),
                      onPressed: () {
                        print("Manual pressed");
                      },
                    )
                ),
              )
            ],
          )
      );
    }
    else if(direction==Axis.vertical) {
      return Positioned(
          top: 0.0,
          left: 0.0,
          child: Column(
            children: [
              Material(
                color : Colors.transparent,
                child: Ink(
                    decoration: const ShapeDecoration(
                        shape: CircleBorder()),
                    child : IconButton(
                      padding: EdgeInsets.only(top : 10, left : 10),
                      constraints: BoxConstraints(),
                      icon: Image.asset('assets/images/icon/uk.png'),
                      onPressed: () {
                        print("UK flag pressed");
                      },
                    )
                ),
              ),
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
                      onPressed: () {
                        print("French flag pressed");
                      },
                    )
                ),
              ),
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
                        print("Manual pressed");
                      },
                    )
                ),
              )
            ],
          )
      );
    }
    else
    {
      print("Direction not supported");
      return Container(
          width: 50,
          height: 50,
          color: Colors.red,
          child : Text("Direction not supported")
      );
    }
  }
}