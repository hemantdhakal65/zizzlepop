import 'dart:math';
import 'package:flame/components.dart';
import 'package:flame/collisions.dart';
import 'package:zizzlepop/screens/zizzlepop/modes/game_mode/game/game_world.dart';
import 'package:zizzlepop/screens/zizzlepop/modes/game_mode/game/components/player.dart';
import 'package:zizzlepop/screens/zizzlepop/modes/game_mode/game/screens/game_over_screen.dart';

class Boss extends SpriteComponent with CollisionCallbacks {
  final PowerBalanceGame gameRef;
  double health = 100;
  double attackPower = 5;
  final Random _random = Random();

  Boss({required Vector2 position, required this.gameRef})
      : super(position: position, size: Vector2.all(150));

  @override
  Future<void> onLoad() async {
    super.onLoad();
    sprite = await Sprite.load('boss.png');
    add(RectangleHitbox()..collisionType = CollisionType.passive);
  }

  @override
  void update(double dt) {
    super.update(dt);
    final dir = (gameRef.player.position - position).normalized();
    position += dir * 100 * dt;
    if (_random.nextDouble() < 0.01) {
      gameRef.decreasePower(attackPower);
    }
  }

  void takeDamage(double damage) {
    health -= damage;
    if (health <= 0) {
      gameRef.gameManager.score += 1000;
      removeFromParent();
      gameRef.overlays.add(GameOverScreen.id);
    }
  }

  @override
  void onCollisionStart(
      Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollisionStart(intersectionPoints, other);
    if (other is Player) {
      takeDamage(gameRef.gameManager.powerLevel / 10);
    }
  }
}
