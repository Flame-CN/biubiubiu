import 'package:flame/animation.dart';
import 'package:flame/sprite.dart';

import 'enemy.dart';

class ShipEnemy extends Enemy {
  ShipEnemy({int score = 100}) : super(life: 5, score: score);

  @override
  void onMount() {
    //165*260
    width = 3 * gameRef.tileSize;
    height = 260 / 165 * width;
    speed = 2 * gameRef.tileSize;
    livingAnimation = Animation.spriteList(
      [
        Sprite("enemy3_n1.png"),
        Sprite("enemy3_n2.png"),
      ],
      stepTime: 0.2,
      loop: true,
    );
    hitAnimation = Animation.spriteList(
      [
        Sprite("enemy3_hit.png"),
      ],
      stepTime: 0.2,
      loop: false,
    );
    destroyAnimation = Animation.spriteList(
      [
        Sprite("enemy3_down1.png"),
        Sprite("enemy3_down2.png"),
        Sprite("enemy3_down3.png"),
        Sprite("enemy3_down4.png"),
        Sprite("enemy3_down5.png"),
        Sprite("enemy3_down6.png"),
      ],
      stepTime: 0.2,
      loop: false,
    );
  }
}
