import 'package:flame/components/component.dart';
import 'package:flame/position.dart';
import 'package:flame/sprite.dart';

class Bullet extends SpriteComponent {
  int speed;

  Bullet({Position position, this.speed = 150}) {
    setByPosition(position);
    width = 5;
    height = 11;
    sprite = Sprite("bullet1.png");
  }

  @override
  void update(double dt) {
    super.update(dt);
    y -= speed * dt;
  }
}
