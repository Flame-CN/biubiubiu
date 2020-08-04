import 'dart:ui';

import 'package:flame_scrolling_sprite/flame_scrolling_sprite.dart';

class Background extends ScrollingSpriteComponent {
  Background(Size size, {double speed = 30, x = 0.0, y = 0.0})
      : super(
          x: x, //图片x方向偏移距离
          y: y, //图片y方向偏移距离
          scrollingSprite: ScrollingSprite(
            spritePath: "background.png",
            spriteWidth: 480,
            spriteHeight: 700,
            width: size.width,
            height: size.height,
            verticalSpeed: speed,
          ),
        );
}
