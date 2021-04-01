import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class IconWidget extends StatelessWidget {
  IconWidget(this.direction);

  final Axis direction;

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
                        print("UK flag pressed");
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
                        print("French flag pressed");
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