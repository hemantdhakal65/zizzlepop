import 'package:flutter/material.dart';
import 'package:zizzlepop/screens/zizzlepop/drawer/drawer_menu.dart';
import 'package:zizzlepop/screens/zizzlepop/modes/quiz_mode/quiz_home.dart';
import 'package:zizzlepop/screens/zizzlepop/modes/guess_mode/guess_home.dart';
import 'package:zizzlepop/screens/zizzlepop/modes/memory_mode/memory_home.dart';
import 'package:zizzlepop/screens/zizzlepop/modes/match_mode/match_home.dart';
import 'package:zizzlepop/screens/zizzlepop/modes/game_mode/game_mode_home.dart';
import 'package:zizzlepop/screens/zizzlepop/widgets/mode_card.dart';
import 'package:zizzlepop/screens/zizzlepop/widgets/hamburger_menu.dart';
import 'package:zizzlepop/screens/zizzlepop/widgets/settings_icon.dart';
import 'package:zizzlepop/utils/constants.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(kAppName),
        leading: const HamburgerMenu(),
        actions: const [SettingsIcon()],
      ),
      drawer: const DrawerMenu(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Grid for the first 4 modes
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                mainAxisSpacing: 20,
                crossAxisSpacing: 20,
                children: const [
                  ModeCard(
                    title: "Quiz Mode",
                    icon: Icons.quiz,
                    screen: QuizHome(),
                  ),
                  ModeCard(
                    title: "Memory Mode",
                    icon: Icons.memory,
                    screen: MemoryHome(),
                  ),
                  ModeCard(
                    title: "Guess Mode",
                    icon: Icons.psychology,
                    screen: GuessHome(),
                  ),
                  ModeCard(
                    title: "Match Mode",
                    icon: Icons.find_in_page,
                    screen: MatchHome(),
                  ),
                ],
              ),
            ),
            // Spacer to push the game mode to the bottom
            const SizedBox(height: 20),
            // Centered Game Mode card
            Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(
                  maxWidth: 200, // Match the grid card width
                ),
                child: const ModeCard(
                  title: "Game Mode",
                  icon: Icons.sports_esports,
                  screen: GameModeHome(),
                ),
              ),
            ),
            const SizedBox(height: 20), // Add some bottom spacing
          ],
        ),
      ),
    );
  }
}