import 'dart:ui';

import 'package:flame/anchor.dart';
import 'package:flame/game.dart';
import 'package:flame/gestures.dart';
import 'package:flame/position.dart';
import 'package:flutter/gestures.dart';

import 'component/background.dart';
import 'component/bullet.dart';
import 'component/enemy/enemy.dart';
import 'component/enemy/enemy_factory.dart';
import 'component/player.dart';

class BiuBiuGame extends BaseGame with PanDetector {
  double tileSize;
  Player player;
  EnemyFactory _enemyFactory;

  BiuBiuGame(Size size) {
    resize(size);
    //添加背景组件
    add(Background(size));
    add(player = Player()
      ..anchor = Anchor.center
      ..setByPosition(Position(size.width / 2, size.height * 0.75)));
    //添加敌人生产工厂组件
    _enemyFactory = EnemyFactory(game: this);
  }

  @override
  void resize(Size size) {
    tileSize = size.width / 9;
    super.resize(size);
  }

  @override
  void update(double t) {
    _enemyFactory?.update(t);
    super.update(t);
    collide();
  }

  @override
  void onPanDown(DragDownDetails details) {}

  @override
  void onPanUpdate(DragUpdateDetails details) {
    if (player.toRect().contains(details.globalPosition)) {
      player.move(details.delta);
    }
  }

  void collide() {
    var bullets = components.whereType<Bullet>().toList();
    components.whereType<Enemy>().forEach((enemy) {
      // player 和 enemy 之间的碰撞检测
      if (enemy.state != EnemyState.DESTROY && player.life > 0 && player.toRect().overlaps(enemy.toRect())) {
        //碰撞全部销毁
        enemy.hurt(enemy.life);
        player.hurt(player.life);
        return;
      }
      // enemy 和 bullet 之间的碰撞检测
      bullets.forEach((bullet) {
        if (enemy.state != EnemyState.DESTROY && bullet.toRect().overlaps(enemy.toRect())) {
          enemy.hurt(bullet.power);
          bullet.isDestroy = true;
        }
      });
    });
  }

  @override
  Color backgroundColor() => Color(0xffc3c8c9);

  @override
  bool debugMode() => false;
}
