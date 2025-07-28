import 'package:flutter/material.dart';
import 'package:zizzlepop/utils/constants.dart';
import 'package:zizzlepop/utils/json_loader.dart';
import 'components/image_card.dart';
import 'components/timer_widget.dart';
import 'components/reveal_animation.dart';
import 'data/sound_manager.dart';

class GuessScreen extends StatefulWidget {
  const GuessScreen({super.key});

  @override
  _GuessScreenState createState() => _GuessScreenState();
}

class _GuessScreenState extends State<GuessScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  int _currentIndex = 0;
  int _score = 0;
  bool _isRevealed = false;
  bool _isLoading = true;
  final TimerType _timerType = TimerType.countdown;
  late Map<String, dynamic> _currentItem;
  List<Map<String, dynamic>> _allItems = [];

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _loadGameData();
  }

  Future<void> _loadGameData() async {
    try {
      final List<String> jsonFiles = [
        'assets/data/guess_mode/animals.json',
        'assets/data/guess_mode/celebrities.json',
        'assets/data/guess_mode/planets.json',
        'assets/data/guess_mode/places.json',
      ];

      List<Map<String, dynamic>> allItems = [];

      for (String file in jsonFiles) {
        try {
          final List<Map<String, dynamic>> items =
          await JsonLoader.loadJson(file);
          allItems.addAll(items);
        } catch (e) {
          print('Error loading $file: $e');
        }
      }

      if (allItems.isEmpty) {
        throw Exception('No game data loaded');
      }

      setState(() {
        _allItems = allItems..shuffle();
        _currentItem = _allItems.first;
        _isLoading = false;
      });
    } catch (e) {
      setState(() => _isLoading = false);
      _showErrorDialog('Failed to load game data: $e');
    }
  }

  void _showErrorDialog(String message) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Error'),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('OK'),
            ),
          ],
        ),
      );
    });
  }

  void _loadNewItem() {
    if (_allItems.isEmpty) return;

    setState(() {
      _currentIndex = (_currentIndex + 1) % _allItems.length;
      _currentItem = _allItems[_currentIndex];
      _isRevealed = false;
    });
    _controller.reset();
  }

  void _revealAnswer() {
    setState(() => _isRevealed = true);
    SoundManager.playAnswerSound(
      _currentItem['sound'],
      _currentItem['category'],
    );
    _controller.forward();
  }

  void _handleGuess(bool isCorrect) {
    if (isCorrect) {
      setState(() => _score += 100);
      SoundManager.playCorrectSound();
    } else {
      SoundManager.playIncorrectSound();
    }
    _revealAnswer();
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return Scaffold(
        appBar: AppBar(title: const Text('Guess Mode')),
        body: const Center(child: CircularProgressIndicator()),
      );
    }

    if (_allItems.isEmpty) {
      return Scaffold(
        appBar: AppBar(title: const Text('Guess Mode')),
        body: const Center(child: Text('No game data available')),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Guess Mode - Score: $_score'),
        backgroundColor: kPrimaryColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              _currentItem['category'].toUpperCase(),
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: kSecondaryColor,
              ),
            ),
            const SizedBox(height: 20),

            Expanded(
              child: ImageCard(
                imagePath: _currentItem['image'],
                onReveal: _revealAnswer,
              ),
            ),

            TimerWidget(
              duration: 5,
              onComplete: _revealAnswer,
              timerType: _timerType,
            ),

            RevealAnimation(
              controller: _controller,
              isRevealed: _isRevealed,
              item: _currentItem,
              onNext: _loadNewItem,
            ),

            if (!_isRevealed) ...[
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () => _handleGuess(true),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                    ),
                    child: const Text('I Know It!'),
                  ),
                  ElevatedButton(
                    onPressed: () => _handleGuess(false),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                    ),
                    child: const Text('No Idea!'),
                  ),
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    SoundManager.dispose();
    super.dispose();
  }
}