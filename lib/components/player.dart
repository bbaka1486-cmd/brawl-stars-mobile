import 'package:flame/components.dart';
import 'package:flutter/material.dart';

import '../game/brawl_stars_game.dart';
import 'bullet.dart';

class Player extends CircleComponent {
  final BrawlStarsGame game;
  late Vector2 velocity;
  double speed = 200;
  double shootCooldown = 0;
  double shootDelay = 0.3;

  Player({
    required Vector2 position,
    required this.game,
  }) : super(
    position: position,
    radius: 20,
    paint: Paint()..color = Colors.green,
  );

  @override
  void update(double dt) {
    super.update(dt);
    
    // Обновляем позицию
    position.add(velocity * dt);
    
    // Ограничиваем позицию в пределах экрана
    position.x = position.x.clamp(radius, game.size.x - radius);
    position.y = position.y.clamp(radius, game.size.y - radius);
    
    // Замедляем скорость
    velocity *= 0.95;
    
    // Обновляем cooldown стрельбы
    if (shootCooldown > 0) {
      shootCooldown -= dt;
    }
  }

  void moveTowards(Vector2 target) {
    final direction = (target - position).normalized();
    velocity = direction * speed;
  }

  void shoot(Vector2 target) {
    if (shootCooldown <= 0) {
      final direction = (target - position).normalized();
      final bullet = Bullet(
        position: position.clone(),
        direction: direction,
        game: game,
      );
      game.addBullet(bullet);
      shootCooldown = shootDelay;
    }
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);
    
    // Рисуем светящийся эффект
    canvas.drawCircle(
      Offset(0, 0),
      radius + 5,
      Paint()
        ..color = Colors.green.withValues(alpha: 0.3)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2,
    );
  }
}
