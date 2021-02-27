/*import 'package:flame/components/component.dart';
import 'package:flame/gestures.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_prototype1/DistributionServices/DistriServGameFlame.dart';

class ClientComponent extends PositionComponent with Draggable{
  final DistriServGameFlame game;

  bool _isDragged = false;
  Rect rect;
  Paint rectColor;

  ClientComponent(this.game) {
    rect = Rect.fromLTWH(50, 50, 10, 20);
    rectColor.color = Color(0xff607D8D);
  }

  @override
  // TODO: implement onDragStarted
  get onDragStarted => super.onDragStarted;
  @override
  // TODO: implement onDragEnd
  get onDragEnd => super.onDragEnd;

  @override
  void render(Canvas c) {
    c.drawRect(rect, rectColor);
  }
}*/