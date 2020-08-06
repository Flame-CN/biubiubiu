import 'dart:math';
import 'dart:ui';

import 'package:biubiubiu/component/bullet.dart';
import 'package:flame/animation.dart';
import 'package:flame/components/component.dart';
import 'package:flame/components/mixins/has_game_ref.dart';
import 'package:flame/sprite.dart';

import '../biu_biu_game.dart';

class Player extends PositionComponent with HasGameRef<BiuBiuGame> {
  Paint overridePaint;
  Animation _live;
  BulletFactory _bulletFactory;

  //生命值
  int life = 1;

  Player({this.life = 1});

  @override
  void onMount() {
    //player图片宽高为102*126 设置player 宽度为 1 tileSize
    width = gameRef.tileSize;
    height = 126 / 102 * gameRef.tileSize;
    //设置player动画
    _live = Animation.spriteList(
      [
        Sprite("me1.png"),
        Sprite("me2.png"),
      ],
      stepTime: 0.2,
    );
    _bulletFactory = BulletFactory(limit: 0.3);
    gameRef.add(_bulletFactory);
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
    prepareCanvas(c);
    if (life >= 0) {
      _live.getSprite().render(c, width: width, height: height, overridePaint: overridePaint);
    }
  }

  @override
  void update(double t) {
    super.update(t);
    if (life >= 0) {
      _live.update(t);
    }
  }
}
