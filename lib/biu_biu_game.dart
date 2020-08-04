import 'dart:ui';
import 'package:biubiubiu/component/background.dart';
import 'package:flame/game.dart';

class BiuBiuGame extends BaseGame {
  BiuBiuGame(Size size) {
    this.size = size;
    //添加背景组件
    add(Background(size));
  }
  @override
  Color backgroundColor() =>Color(0xffc3c8c9);
}