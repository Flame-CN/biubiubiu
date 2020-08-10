import 'package:flame/anchor.dart';
import 'package:flame/components/component.dart';
import 'package:flame/components/mixins/has_game_ref.dart';
import 'package:flame/position.dart';
import 'package:flame/sprite.dart';
import 'package:flame/time.dart';
import 'package:flutter/cupertino.dart';

import '../biu_biu_game.dart';

class Bullet extends SpriteComponent {
  //子弹的速度
  double speed;

  //子弹的伤害
  int power;

  //是否销毁
  bool isDestroy = false;

  Bullet({Position position, this.speed = 300.0, this.power = 1, String img = "bullet1.png"}) {
    setByPosition(position);
    width = 5.0;
    height = 11.0;
    sprite = Sprite(img);
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

  @override
  int priority() => 10;
}

class BulletFactory with HasGameRef<BiuBiuGame> {
  Timer _timer;
  double limit;

  BulletFactory({@required BiuBiuGame game, this.limit = 1}) {
    gameRef = game;
    _timer = Timer(limit, repeat: true, callback: () {
      gameRef.addLater(Bullet(position: gameRef.player.toPosition()));
    });
    _timer.start();
  }

  void update(double t) {
    _timer.update(t);
  }
}
