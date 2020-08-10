import 'dart:ui';

import 'package:flame/anchor.dart';
import 'package:flame/components/text_component.dart';
import 'package:flame/game.dart';
import 'package:flame/gestures.dart';
import 'package:flame/position.dart';
import 'package:flame/text_config.dart';
import 'package:flame/time.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/widgets.dart';

import 'component/background.dart';
import 'component/bullet.dart';
import 'component/enemy/enemy.dart';
import 'component/enemy/enemy_factory.dart';
import 'component/player.dart';

class BiuBiuGame extends BaseGame with PanDetector, HasWidgetsOverlay {
  double tileSize;
  Player player;
  EnemyFactory _enemyFactory;

  int score;
  TextComponent scoreComponent;
  Timer restartTimer;

  BiuBiuGame(Size size) {
    resize(size);
    init();
  }

  void init() {
    components.clear();
    score=0;
    //添加背景组件
    add(Background(size));
    add(player = Player()
      ..anchor = Anchor.center
      ..setByPosition(Position(size.width / 2, size.height * 0.75)));
    //添加敌人生产工厂组件
    _enemyFactory = EnemyFactory(game: this);
    scoreComponent = TextComponent("SCORE $score", config: TextConfig(color: Color(0xffffffff)))
      ..x = 10
      ..y = 10;
    restartTimer = Timer(3.0, callback: () {
      removeWidgetOverlay("gameOver");
      init();
    });
  }

  void gameOver() {
    restartTimer.start();
    addWidgetOverlay(
        "gameOver",
        Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "您的最终分数:$score",
                style: TextStyle(
                  color: Color(0xffffffff),
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ));
  }

  @override
  void resize(Size size) {
    tileSize = size.width / 9;
    super.resize(size);
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);
    scoreComponent.render(canvas);
  }

  @override
  void update(double t) {
    super.update(t);
    //生成敌人
    _enemyFactory?.update(t);
    restartTimer.update(t);
    //检测碰撞
    collide();
    //计算分数
    scoreComponent.text = "SCORE $score";
  }

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
        gameOver();
        return;
      }
      // enemy 和 bullet 之间的碰撞检测
      bullets.forEach((bullet) {
        //当player生命值大于0,enemy状态不为DESTROY时,才进行bullet和enemy的碰撞检测
        if (enemy.state != EnemyState.DESTROY && player.life > 0 && bullet.toRect().overlaps(enemy.toRect())) {
          enemy.hurt(bullet.power);
          bullet.isDestroy = true;
          //当enemy被击毁时,计算得分
          if (enemy.state == EnemyState.DESTROY) {
            score += enemy.score;
          }
        }
      });
    });
  }

  @override
  Color backgroundColor() => Color(0xffc3c8c9);

  @override
  bool debugMode() => false;
}
