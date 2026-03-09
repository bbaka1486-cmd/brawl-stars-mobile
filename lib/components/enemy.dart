import 'package:flame/components.dart';
import 'package:flutter/material.dart';

import '../game/brawl_stars_game.dart';

class Enemy extends CircleComponent {
  final BrawlStarsGame game;
  late Vector2 velocity;
  double speed = 100;
  int health = 30;
  double attackCooldown = 0;

  Enemy({
    required Vector2 position,
    required this.game,
  }) : super(
    position: position,
    radius: 15,
    paint: Paint()..color = Colors.orange,
  );

  @override
  void update(double dt) {
    super.update(dt);
    
    // Движение к игроку
    final direction = (game.player.position - position).normalized();
    velocity = direction * speed;
    position.add(velocity * dt);
    
    // Ограничиваем позицию в пределах экрана
    position.x = position.x.clamp(radius, game.size.x - radius);
    position.y = position.y.clamp(radius, game.size.y - radius);
    
    // Проверяем столкновение с игроком
    final distance = position.distanceTo(game.player.position);
    if (distance < radius + game.player.radius) {
      attackCooldown -= dt;
      if (attackCooldown <= 0) {
        game.damagePlayer(5);
        attackCooldown = 1.0;
      }
    }
    
    // Обновляем cooldown атаки
    if (attackCooldown > 0) {
      attackCooldown -= dt;
    }
  }

  void takeDamage(int damage) {
    health -= damage;
    if (health <= 0) {
      game.removeEnemy(this);
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
        ..color = Colors.orange.withValues(alpha: 0.3)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2,
    );
  }
}
