import 'package:flame/animation.dart';
import 'package:flame/sprite.dart';

import 'enemy.dart';

class MiniPlane extends Enemy {
  MiniPlane({int score = 10}) : super(life: 1, score: score);

  @override
  void onMount() {
    //57*43
    width = gameRef.tileSize;
    height = 43 / 57 * width;
    //速度
    speed = 5 * gameRef.tileSize;
    livingAnimation = Animation.spriteList(
      [
        Sprite("enemy1.png"),
      ],
      stepTime: 0.2,
      loop: true,
    );
    destroyAnimation = Animation.spriteList(
      [
        Sprite("enemy1_down1.png"),
        Sprite("enemy1_down2.png"),
        Sprite("enemy1_down3.png"),
        Sprite("enemy1_down4.png"),
      ],
      stepTime: 0.2,
      loop: false,
    );
  }
}
