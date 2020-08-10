import 'dart:ui';

import 'package:flame/animation.dart';
import 'package:flame/components/component.dart';
import 'package:flame/components/mixins/has_game_ref.dart';

import '../../biu_biu_game.dart';

enum EnemyState { LIVING, HIT, DESTROY }

class Enemy extends PositionComponent with HasGameRef<BiuBiuGame> {
  Animation livingAnimation;
  Animation hitAnimation;
  Animation destroyAnimation;

  EnemyState state = EnemyState.LIVING;

  //生命值
  int life;

  //伤害值
  int power;

  //速度
  double speed;

  //击败后得分
  int score;
  bool isDestroy = false;

  Enemy({this.life = 1, this.power = 1, this.speed = 150, this.score = 1});

  @override
  void render(Canvas c) {
    prepareCanvas(c);
    switch (state) {
      case EnemyState.LIVING:
        livingAnimation?.getSprite()?.render(c, width: width, height: height);
        break;
      case EnemyState.HIT:
        hitAnimation?.getSprite()?.render(c, width: width, height: height);
        break;
      case EnemyState.DESTROY:
        destroyAnimation?.getSprite()?.render(c, width: width, height: height);
        break;
    }
  }

  @override
  void update(double dt) {
    super.update(dt);
    switch (state) {
      case EnemyState.LIVING:
        livingAnimation?.update(dt);
        break;
      case EnemyState.HIT:
        hitAnimation?.update(dt);
        if (hitAnimation != null && hitAnimation.done()) {
          state = EnemyState.LIVING;
        }
        break;
      case EnemyState.DESTROY:
        destroyAnimation?.update(dt);
        if (destroyAnimation.done()) {
          isDestroy = true;
        }
        break;
    }
    //战机生成后向下移动
    y += speed * dt;
    //超出屏幕销毁
    if (y > gameRef.size.height + height) {
      isDestroy = true;
    }
  }

  void hurt(int power) {
    life -= power;
    if (life > 0) {
      state = EnemyState.HIT;
    } else {
      state = EnemyState.DESTROY;
    }
  }

  @override
  bool destroy() => isDestroy;

  @override
  int priority() => 2;
}
