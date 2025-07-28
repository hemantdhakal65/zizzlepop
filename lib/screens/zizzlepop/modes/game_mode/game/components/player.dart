import 'package:flame/components.dart';
import 'package:flame/collisions.dart';

class Player extends SpriteComponent with CollisionCallbacks {
  Player({required Vector2 position})
      : super(position: position, size: Vector2.all(50));

  final double moveSpeed = 300;
  Vector2? _target;

  @override
  Future<void> onLoad() async {
    super.onLoad();
    sprite = await Sprite.load('player.png');
    add(CircleHitbox()..collisionType = CollisionType.passive);
  }

  void moveTo(Vector2 destination) {
    _target = destination;
  }

  @override
  void update(double dt) {
    super.update(dt);
    if (_target != null) {
      final dir = (_target! - position);
      if (dir.length < moveSpeed * dt) {
        position.setFrom(_target!);
        _target = null;
      } else {
        position += dir.normalized() * moveSpeed * dt;
      }
    }
    position.x = position.x.clamp(0, (findGame()?.size.x ?? 0) - size.x);
    position.y = position.y.clamp(0, (findGame()?.size.y ?? 0) - size.y);
  }
}
