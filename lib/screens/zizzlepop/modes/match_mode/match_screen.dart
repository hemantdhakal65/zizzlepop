import 'dart:async';
import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:zizzlepop/screens/zizzlepop/modes/match_mode/components/match_card.dart';
import 'package:zizzlepop/screens/zizzlepop/modes/match_mode/components/score_board.dart';
import 'package:zizzlepop/screens/zizzlepop/modes/match_mode/components/timer_widget.dart';
import 'package:zizzlepop/screens/zizzlepop/modes/match_mode/data/match_data_manager.dart';
import 'package:zizzlepop/utils/constants.dart';

class MatchScreen extends StatefulWidget {
  final String category;

  const MatchScreen({super.key, required this.category});

  @override
  _MatchScreenState createState() => _MatchScreenState();
}

class _MatchScreenState extends State<MatchScreen> {
  late List<Map<String, dynamic>> _items;
  late List<Map<String, dynamic>> _gameItems;
  int _score = 0;
  bool _isLoading = true;
  int _currentRound = 0;
  int? _selectedIndex;
  int? _correctIndex;
  bool _showResult = false;
  final AudioPlayer _audioPlayer = AudioPlayer();
  int _remainingTime = 30;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _loadItems();
    _startTimer();
  }

  Future<void> _loadItems() async {
    try {
      _items = await MatchDataManager.getItems(category: widget.category);
      _setupGame();
      setState(() => _isLoading = false);
    } catch (e) {
      setState(() => _isLoading = false);
    }
  }

  void _setupGame() {
    _gameItems = List.from(_items);
    _gameItems.shuffle();
    _currentRound = 0;
    _score = 0;
    _selectedIndex = null;
    _correctIndex = null;
    _showResult = false;
    _remainingTime = 30;
    _nextRound();
  }

  void _nextRound() {
    if (_currentRound >= _gameItems.length) {
      _showGameOver();
      return;
    }

    setState(() {
      _currentRound++;
      _selectedIndex = null;
      _correctIndex = null;
      _showResult = false;
      _remainingTime = 30;
    });
  }

  void _playSound(String sound) async {
    await _audioPlayer.stop();
    await _audioPlayer.play(AssetSource('sounds/${widget.category}/$sound'));
  }

  void _selectOption(int index) {
    if (_selectedIndex != null) return;

    setState(() {
      _selectedIndex = index;
      _showResult = true;
    });

    if (index == _correctIndex) {
      setState(() => _score += 10);
      Future.delayed(const Duration(seconds: 1), _nextRound);
    } else {
      _playSound(_gameItems[_currentRound - 1]['sound']);
    }
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_remainingTime > 0) {
        setState(() => _remainingTime--);
      } else {
        _nextRound();
      }
    });
  }

  void _showGameOver() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Game Over'),
        content: Text('Your final score: $_score'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              _setupGame();
            },
            child: const Text('Play Again'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Quit'),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _timer?.cancel();
    _audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return Scaffold(
        appBar: AppBar(title: Text('${widget.category} Match')),
        body: const Center(child: CircularProgressIndicator()),
      );
    }

    if (_items.isEmpty) {
      return Scaffold(
        appBar: AppBar(title: Text('${widget.category} Match')),
        body: const Center(child: Text('No items available')),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.category} Match'),
        backgroundColor: kPrimaryColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            ScoreBoard(score: _score, round: _currentRound, total: _gameItems.length),
            const SizedBox(height: 20),
            TimerWidget(
              duration: _remainingTime,
              timerType: TimerType.progress,
            ),
            const SizedBox(height: 20),
            Expanded(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.volume_up, size: 50),
                      onPressed: () => _playSound(_gameItems[_currentRound - 1]['sound']),
                    ),
                    const SizedBox(height: 30),
                    const Text(
                      'What sound is this?',
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 20),
                    Wrap(
                      spacing: 15,
                      runSpacing: 15,
                      children: List.generate(
                        _gameItems[_currentRound - 1]['options'].length,
                            (index) => MatchCard(
                          item: _gameItems[_currentRound - 1]['options'][index],
                          isSelected: _selectedIndex == index,
                          isCorrect: _showResult && index == _correctIndex,
                          onTap: () => _selectOption(index),
                          type: widget.category,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}