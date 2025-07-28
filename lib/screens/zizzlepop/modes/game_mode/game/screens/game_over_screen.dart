import 'package:flutter/material.dart';
import 'package:zizzlepop/screens/zizzlepop/modes/game_mode/game/game_world.dart';

class GameOverScreen extends StatelessWidget {
  static const id = 'game-over';
  final PowerBalanceGame game;

  const GameOverScreen(this.game, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isWin = game.gameManager.powerLevel > 0;
    return Material(
      color: Colors.black54,
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              isWin ? 'VICTORY!' : 'GAME OVER',
              style: const TextStyle(fontSize: 48, color: Colors.white, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            Text('Power: ${game.gameManager.powerLevel.toStringAsFixed(1)}%', style: const TextStyle(fontSize: 24, color: Colors.white)),
            Text('Score: ${game.gameManager.score}', style: const TextStyle(fontSize: 24, color: Colors.white)),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                game.overlays.remove(id);
                game.resetGame();
              },
              child: const Text('Play Again'),
            ),
          ],
        ),
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:zizzlepop/screens/zizzlepop/modes/game_mode/game/game_world.dart';

class GameOverScreen extends StatelessWidget {
  static const id = 'game-over';
  final PowerBalanceGame game;

  const GameOverScreen(this.game, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isWin = game.gameManager.powerLevel > 0;
    return Material(
      color: Colors.black54,
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              isWin ? 'VICTORY!' : 'GAME OVER',
              style: const TextStyle(fontSize: 48, color: Colors.white, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            Text('Power: ${game.gameManager.powerLevel.toStringAsFixed(1)}%', style: const TextStyle(fontSize: 24, color: Colors.white)),
            Text('Score: ${game.gameManager.score}', style: const TextStyle(fontSize: 24, color: Colors.white)),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                game.overlays.remove(id);
                game.resetGame();
              },
              child: const Text('Play Again'),
            ),
          ],
        ),
      ),
    );
  }
}
