import 'package:flame/flame.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'biu_biu_game.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  if (!kIsWeb) {
    //设置全屏
    await Flame.util.fullScreen();
    //设置屏幕方向只能竖屏显示
    await Flame.util.setPortraitDownOnly();
  }

  //获取屏幕size
  final Size size = await Flame.util.initialDimensions();
  //稍后创建BiuBiuGame类
  runApp(BiuBiuGame(size).widget);
}
