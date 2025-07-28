import 'dart:math';
import 'package:flame/components.dart';
import 'package:flame/collisions.dart';
import 'package:zizzlepop/screens/zizzlepop/modes/game_mode/game/game_world.dart';
import 'package:zizzlepop/screens/zizzlepop/modes/game_mode/game/components/player.dart';

enum ObjectType {
  apple(asset: 'apple.png', powerEffect: 10, isGood: true),
  burger(asset: 'burger.png', powerEffect: -5, isGood: false),
  snake(asset: 'snake.png', powerEffect: -15, isGood: false),
  book(asset: 'book.png', powerEffect: 8, isGood: true),
  bomb(asset: 'bomb.png', powerEffect: -20, isGood: false);

  final String asset;
  final double powerEffect;
  final bool isGood;
  const ObjectType({
    required this.asset,
    required this.powerEffect,
    required this.isGood,
  });
}

class FallingObject extends SpriteComponent with CollisionCallbacks {
  static final Random _random = Random();
  final ObjectType type;
  final double fallSpeed = 200;

  FallingObject({required Vector2 position})
      : type = ObjectType.values[_random.nextInt(ObjectType.values.length)],
        super(position: position, size: Vector2.all(40));

  @override
  Future<void> onLoad() async {
    super.onLoad();
    sprite = await Sprite.load(type.asset);
    add(CircleHitbox()..collisionType = CollisionType.passive);
  }

  @override
  void update(double dt) {
    super.update(dt);
    position.y += fallSpeed * dt;
    if (position.y > (findGame<PowerBalanceGame>()?.size.y ?? double.infinity)) {
      removeFromParent();
    }
  }

  @override
  void onCollisionStart(
      Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollisionStart(intersectionPoints, other);
    if (other is Player) {
      final game = findGame<PowerBalanceGame>()!;
      if (type.isGood) {
        game.increasePower(type.powerEffect);
      } else {
        game.decreasePower(-type.powerEffect);
      }
      removeFromParent();
    }
  }
}
