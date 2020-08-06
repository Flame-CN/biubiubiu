import 'dart:ui';

import 'package:biubiubiu/biu_biu_game.dart';
import 'package:flame/anchor.dart';
import 'package:flame/components/component.dart';
import 'package:flame/components/mixins/has_game_ref.dart';
import 'package:flame/position.dart';
import 'package:flame/sprite.dart';
import 'package:flame/time.dart';
import 'package:flutter/cupertino.dart';

import 'player.dart';

class Bullet extends SpriteComponent {
  //子弹的速度
  double speed;
  //子弹的伤害
  double power;
  //是否销毁
  bool isDestroy = false;

  Bullet({Position position, this.speed = 300.0, this.power = 1.0}) {
    setByPosition(position);
    width = 5.0;
    height = 11.0;
    sprite = Sprite("bullet1.png");
    anchor = Anchor.center;
  }

  @override
  void update(double dt) {
    super.update(dt);
    y -= speed * dt;
    //子弹超出屏幕销毁
    if (y < 0) {
      isDestroy = true;
    }
  }

  @override
  bool destroy() => isDestroy;
}

class BulletFactory extends Component with HasGameRef<BiuBiuGame> {
  Player player;
  Timer _timer;
  double limit;

  BulletFactory({this.limit = 1});

  @override
  void onMount() {
    _timer = Timer(limit, repeat: true, callback: () {
      gameRef.add(Bullet(position: gameRef.player.toPosition()));
    });
    _timer.start();
  }

  @override
  void render(Canvas c) {}

  @override
  void update(double t) {
    _timer.update(t);
  }
}
