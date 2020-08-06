import 'dart:ui';

import 'package:flame/anchor.dart';
import 'package:flame/game.dart';
import 'package:flame/gestures.dart';
import 'package:flame/position.dart';
import 'package:flutter/gestures.dart';

import 'component/background.dart';
import 'component/player.dart';

class BiuBiuGame extends BaseGame with PanDetector {
  double tileSize;
  Player player;

  BiuBiuGame(Size size) {
    resize(size);
    //添加背景组件
    add(Background(size));
    add(player = Player()
      ..anchor = Anchor.center
      ..setByPosition(Position(size.width / 2, size.height * 0.75)));
  }

  @override
  void resize(Size size) {
    tileSize = size.width / 9;
    super.resize(size);
  }

  @override
  void update(double t) {
    super.update(t);
  }


  @override
  void onPanDown(DragDownDetails details) {

  }


  @override
  void onPanUpdate(DragUpdateDetails details) {
    if(player.toRect().contains(details.globalPosition)){
      player.move(details.delta);
    }
  }

  @override
  Color backgroundColor() => Color(0xffc3c8c9);
}
