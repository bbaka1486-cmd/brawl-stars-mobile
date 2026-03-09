import 'package:flame/game.dart';
import 'package:flame/events.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'package:vector_math/vector_math.dart';
import '../components/player.dart';
import '../components/enemy.dart';
import '../components/bullet.dart';

class BrawlStarsGame extends FlameGame {
  late Player player;
  final List<Enemy> enemies = [];
  final List<Bullet> bullets = [];
  
  int score = 0;
  int health = 100;
  int enemyCount = 0;
  int level = 1;
  bool isGameOver = false;

  @override
  Future<void> onLoad() async {
    super.onLoad();
    
    // Установка размера камеры
    camera.viewfinder.zoom = 1.0;
    
    // Создание игрока в центре
    player = Player(
      position: size / 2,
      game: this,
    );
    add(player);

    // Спавн начальных врагов
    spawnEnemies(4);
  }

  void spawnEnemies(int count) {
    for (int i = 0; i < count; i++) {
      final angle = (i / count) * 3.14159 * 2;
      final distance = 150.0;
      final x = size.x / 2 + distance * math.cos(angle);
      final y = size.y / 2 + distance * math.sin(angle);
      
      final enemy = Enemy(
        position: Vector2(x, y),
        game: this,
      );
      add(enemy);
      enemies.add(enemy);
    }
    enemyCount = enemies.length;
  }

  void addBullet(Bullet bullet) {
    add(bullet);
    bullets.add(bullet);
  }

  void removeBullet(Bullet bullet) {
    remove(bullet);
    bullets.remove(bullet);
  }

  void removeEnemy(Enemy enemy) {
    remove(enemy);
    enemies.remove(enemy);
    score += 100;
    enemyCount = enemies.length;

    // Спавн нового врага
    if (enemies.length < 4 + level) {
      final angle = math.Random().nextDouble() * 3.14159 * 2;
      final distance = 200.0;
      final x = size.x / 2 + distance * math.cos(angle);
      final y = size.y / 2 + distance * math.sin(angle);
      
      final enemy = Enemy(
        position: Vector2(x, y),
        game: this,
      );
      add(enemy);
      enemies.add(enemy);
      enemyCount = enemies.length;
    }
  }

  void damagePlayer(int damage) {
    health -= damage;
    if (health <= 0) {
      isGameOver = true;
      health = 0;
    }
  }

  @override
  void onDragStart(DragStartEvent event) {
    final position = event.localPosition;
    player.moveTowards(position);
  }

  @override
  void onDragUpdate(DragUpdateEvent event) {
    final position = event.localPosition;
    player.moveTowards(position);
  }

  @override
  void onTapDown(TapDownEvent event) {
    final position = event.localPosition;
    player.shoot(position);
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);
    
    // Рисуем HUD
    drawHUD(canvas);
    
    if (isGameOver) {
      drawGameOver(canvas);
    }
  }

  void drawHUD(Canvas canvas) {
    final textPainter = TextPainter(
      text: TextSpan(
        text: 'Health: $health | Score: $score | Enemies: $enemyCount',
        style: const TextStyle(
          color: Colors.cyan,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
      textDirection: TextDirection.ltr,
    );
    textPainter.layout();
    textPainter.paint(canvas, const Offset(10, 10));
  }

  void drawGameOver(Canvas canvas) {
    // Полупрозрачный фон
    canvas.drawRect(
      Rect.fromLTWH(0, 0, size.x, size.y),
      Paint()..color = Colors.black.withValues(alpha: 0.7),
    );

    // Текст Game Over
    final gameOverText = TextPainter(
      text: const TextSpan(
        text: 'GAME OVER',
        style: TextStyle(
          color: Colors.red,
          fontSize: 48,
          fontWeight: FontWeight.bold,
        ),
      ),
      textDirection: TextDirection.ltr,
    );
    gameOverText.layout();
    gameOverText.paint(
      canvas,
      Offset(
        (size.x - gameOverText.width) / 2,
        (size.y - gameOverText.height) / 2 - 50,
      ),
    );

    // Текст Score
    final scoreText = TextPainter(
      text: TextSpan(
        text: 'Final Score: $score',
        style: const TextStyle(
          color: Colors.cyan,
          fontSize: 24,
        ),
      ),
      textDirection: TextDirection.ltr,
    );
    scoreText.layout();
    scoreText.paint(
      canvas,
      Offset(
        (size.x - scoreText.width) / 2,
        (size.y - scoreText.height) / 2 + 20,
      ),
    );
  }
}
