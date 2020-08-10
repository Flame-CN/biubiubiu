import 'dart:math';

import 'package:flame/components/mixins/has_game_ref.dart';
import 'package:flame/position.dart';
import 'package:flame/time.dart';
import 'package:flutter/cupertino.dart';

import '../../biu_biu_game.dart';
import 'enemy.dart';
import 'mini_plane.dart';
import 'ship_enemy.dart';
import 'warplane.dart';

class EnemyFactory with HasGameRef<BiuBiuGame> {
  Timer _timer;
  Random _random = Random();

  EnemyFactory({@required BiuBiuGame game, double limit = 1}) {
    gameRef = game;
    _timer = Timer(limit, repeat: true, callback: () {
      gameRef.addLater(generate());
    });
    _timer.start();
  }

  void update(double dt) {
    _timer.update(dt);
  }

  Enemy generate() {
    switch (_random.nextInt(3)) {
      case 1:
        return MiniPlane()..setByPosition(randomPosition(gameRef.tileSize, 43 / 57 * gameRef.tileSize));
        break;
      case 2:
        return Warplane()..setByPosition(randomPosition(1.5 * gameRef.tileSize, (95 / 69) * 1.5 * gameRef.tileSize));
        break;
      default:
        return ShipEnemy()..setByPosition(randomPosition(3 * gameRef.tileSize, (260 / 165) * 3 * gameRef.tileSize));
        break;
    }
  }

  Position randomPosition(double width, height) {
    return Position(_random.nextDouble() * (gameRef.size.width - width), -height);
  }
}
