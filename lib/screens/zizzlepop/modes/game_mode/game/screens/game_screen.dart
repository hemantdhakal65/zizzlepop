import 'package:flutter/material.dart';
import 'package:flame/game.dart';
import 'package:zizzlepop/screens/zizzlepop/modes/game_mode/game/game_world.dart';
import 'package:zizzlepop/screens/zizzlepop/modes/game_mode/game/screens/game_over_screen.dart';

class GameScreen extends StatelessWidget {
  const GameScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final game = PowerBalanceGame();
    return Scaffold(
      body: GameWidget(
        game: game,
        overlayBuilderMap: {
          GameOverScreen.id: (_, __) => GameOverScreen(game),
        },
      ),
    );
  }
}
