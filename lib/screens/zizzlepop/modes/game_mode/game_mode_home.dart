import 'package:flutter/material.dart';
import 'package:zizzlepop/screens/zizzlepop/widgets/back_button.dart';
import 'package:zizzlepop/screens/zizzlepop/modes/game_mode/game/screens/game_screen.dart';

class GameModeHome extends StatelessWidget {
  const GameModeHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Power Balance Game'),
        leading: const CustomBackButton(),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const GameScreen()),
            );
          },
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
            textStyle: const TextStyle(fontSize: 24),
          ),
          child: const Text('Start Game'),
        ),
      ),
    );
  }
}