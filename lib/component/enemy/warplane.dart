import 'package:flame/animation.dart';
import 'package:flame/sprite.dart';

import 'enemy.dart';

class Warplane extends Enemy {
  Warplane({int score = 50}) : super(life: 3, score: score);

  @override
  void onMount() {
    //69*95
    width = 1.5 * gameRef.tileSize;
    height = 95 / 69 * width;
    speed = 3 * gameRef.tileSize;
    livingAnimation = Animation.spriteList(
      [
        Sprite("enemy2.png"),
      ],
      stepTime: 0.2,
      loop: true,
    );
    hitAnimation = Animation.spriteList(
      [
        Sprite("enemy2_hit.png"),
      ],
      stepTime: 0.2,
      loop: false,
    );
    destroyAnimation = Animation.spriteList(
      [
        Sprite("enemy2_down1.png"),
        Sprite("enemy2_down2.png"),
        Sprite("enemy2_down3.png"),
        Sprite("enemy2_down4.png"),
      ],
      stepTime: 0.2,
      loop: false,
    );
  }
}
