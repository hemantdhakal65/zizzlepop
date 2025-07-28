import 'dart:math';
import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/timer.dart';
import 'package:zizzlepop/screens/zizzlepop/modes/game_mode/game/components/player.dart';
import 'package:zizzlepop/screens/zizzlepop/modes/game_mode/game/components/falling_object.dart';
import 'package:zizzlepop/screens/zizzlepop/modes/game_mode/game/components/boss.dart';
import 'package:zizzlepop/screens/zizzlepop/modes/game_mode/game/components/power_bar.dart';
import 'package:zizzlepop/screens/zizzlepop/modes/game_mode/game/components/game_manager.dart';

class PowerBalanceGame extends FlameGame
    with HasCollisionDetection, TapDetector {
  late Player player;
  late GameManager gameManager;
  late PowerBar powerBar;
  late TimerComponent objectSpawnTimer;
  late TimerComponent bossTimer;

  bool isBossFight = false;
  final Random _random = Random();

  @override
  Future<void> onLoad() async {
    super.onLoad();

    gameManager = GameManager();
    add(gameManager);

    player = Player(position: size / 2);
    add(player);

    powerBar = PowerBar(position: Vector2(20, 20));
    add(powerBar);

    objectSpawnTimer = TimerComponent(
      period: 1.0,
      repeat: true,
      onTick: () {
        if (!isBossFight) {
          add(FallingObject(
            position: Vector2(
              size.x * .1 + (size.x * .8) * _random.nextDouble(),
              0,
            ),
          ));
        }
      },
    );
    add(objectSpawnTimer);

    bossTimer = TimerComponent(
      period: 60.0,
      repeat: false,
      onTick: startBossFight,
    );
    add(bossTimer);
  }

  void startBossFight() {
    isBossFight = true;
    add(Boss(
      position: Vector2(size.x / 2, 100),
      gameRef: this,
    ));
  }

  void increasePower(double amount) {
    gameManager.powerLevel = (gameManager.powerLevel + amount).clamp(0, 100);
    powerBar.updatePower(gameManager.powerLevel);
  }

  void decreasePower(double amount) {
    gameManager.powerLevel = (gameManager.powerLevel - amount).clamp(0, 100);
    powerBar.updatePower(gameManager.powerLevel);
    if (gameManager.powerLevel <= 0) {
      overlays.add(GameOverScreen.id);
    }
  }

  @override
  void onTapDown(TapDownInfo info) {
    // Use the game‐position of the tap
    final target = info.eventPosition.game;
    player.moveTo(target);
  }

  void resetGame() {
    children.clear();
    isBossFight = false;
    gameManager.reset();
    onLoad();
  }
}
