import 'dart:math';
import 'dart:ui';

import 'package:flame/animation.dart';
import 'package:flame/components/animation_component.dart';
import 'package:flame/components/component.dart';
import 'package:flame/components/mixins/has_game_ref.dart';
import 'package:flame/sprite.dart';

import '../biu_biu_game.dart';

class Player extends PositionComponent with HasGameRef<BiuBiuGame> {
  AnimationComponent _live;

  //生命值
  int life = 1;

  Player({this.life = 1});

  @override
  void onMount() {
    //player图片宽高为102*126 设置player 宽度为 1 tileSize
    width = gameRef.tileSize;
    height = 126 / 102 * gameRef.tileSize;
    //设置player
    _live = AnimationComponent(
      width,
      height,
      Animation.spriteList(
        [
          Sprite("me1.png"),
          Sprite("me2.png"),
        ],
        stepTime: 0.2,
      ),
    )
      ..anchor = anchor //设置中心点
      ..setByPosition(toPosition()); //设置位置
  }

  void move(Offset offset) {
    x += offset.dx;
    x = max(0.0, x);
    x = min(gameRef.size.width, x);
    y += offset.dy;
    y = max(0.0, y);
    y = min(gameRef.size.height, y);
  }

  @override
  void render(Canvas c) {
    if (life >= 0) {
      _live.render(c);
    }
  }

  @override
  void update(double t) {
    super.update(t);
    _live.update(t);
    _live.x = x;
    _live.y = y;
  }
}
