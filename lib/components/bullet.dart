import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import '../game/brawl_stars_game.dart';

class Bullet extends CircleComponent {
  final BrawlStarsGame game;
  late Vector2 velocity;
  double speed = 400;
  double lifetime = 5.0;

  Bullet({
    required Vector2 position,
    required Vector2 direction,
    required this.game,
  }) : super(
    position: position,
    radius: 5,
    paint: Paint()..color = Colors.cyan,
  ) {
    velocity = direction * speed;
  }

  @override
  void update(double dt) {
    super.update(dt);
    
    // Движение пули
    position.add(velocity * dt);
    
    // Уменьшаем время жизни
    lifetime -= dt;
    
    // Удаляем пулю если она вышла за пределы экрана или истекло время
    if (lifetime <= 0 || 
        position.x < 0 || 
        position.x > game.size.x ||
        position.y < 0 ||
        position.y > game.size.y) {
      game.removeBullet(this);
      return;
    }
    
    // Проверяем столкновение с врагами
    for (final enemy in game.enemies) {
      final distance = position.distanceTo(enemy.position);
      if (distance < radius + enemy.radius) {
        enemy.takeDamage(25);
        game.removeBullet(this);
        return;
      }
    }
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);
    
    // Рисуем светящийся эффект
    canvas.drawCircle(
      Offset(0, 0),
      radius + 3,
      Paint()
        ..color = Colors.cyan.withValues(alpha: 0.5)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1,
    );
  }
}
