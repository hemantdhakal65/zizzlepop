import 'package:flutter/material.dart';
import 'package:zizzlepop/screens/zizzlepop/modes/quiz_mode/components/progress_bar.dart';
import 'package:zizzlepop/screens/zizzlepop/modes/quiz_mode/components/question_card.dart';
import 'package:zizzlepop/screens/zizzlepop/modes/quiz_mode/components/timer_widget.dart';
import 'package:zizzlepop/screens/zizzlepop/modes/quiz_mode/data/quiz_data_manager.dart';
import 'package:zizzlepop/utils/constants.dart';

class QuizScreen extends StatefulWidget {
  final String category;

  const QuizScreen({super.key, required this.category});

  @override
  _QuizScreenState createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  late List<Map<String, dynamic>> _questions;
  int _currentIndex = 0;
  int _score = 0;
  bool _isLoading = true;
  bool _answerSelected = false;
  int? _selectedOption;
  bool _showSolution = false;

  @override
  void initState() {
    super.initState();
    _loadQuestions();
  }

  Future<void> _loadQuestions() async {
    try {
      _questions = await QuizDataManager.getQuestions(
        category: widget.category,
        count: 15,
      );
      setState(() => _isLoading = false);
    } catch (e) {
      // Handle error
      setState(() => _isLoading = false);
    }
  }

  void _nextQuestion() {
    setState(() {
      _currentIndex++;
      _answerSelected = false;
      _selectedOption = null;
      _showSolution = false;
    });
  }

  void _selectOption(int index) {
    if (_answerSelected) return;

    setState(() {
      _selectedOption = index;
      _answerSelected = true;
      _showSolution = true;

      if (index == _currentQuestion['correctIndex']) {
        _score += 10;
      }
    });
  }

  Map<String, dynamic> get _currentQuestion {
    return _questions[_currentIndex];
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return Scaffold(
        appBar: AppBar(title: Text('${widget.category} Quiz')),
        body: const Center(child: CircularProgressIndicator()),
      );
    }

    if (_questions.isEmpty) {
      return Scaffold(
        appBar: AppBar(title: Text('${widget.category} Quiz')),
        body: const Center(child: Text('No questions available')),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.category} Quiz - Score: $_score'),
        backgroundColor: kPrimaryColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            ProgressBar(
              current: _currentIndex + 1,
              total: _questions.length,
            ),
            const SizedBox(height: 20),
            TimerWidget(
              duration: 30,
              onComplete: () => _selectOption(-1),
              timerType: TimerType.progress,
            ),
            const SizedBox(height: 20),
            Expanded(
              child: QuestionCard(
                question: _currentQuestion,
                selectedOption: _selectedOption,
                showSolution: _showSolution,
                onOptionSelected: _selectOption,
              ),
            ),
            const SizedBox(height: 20),
            if (_answerSelected)
              ElevatedButton(
                onPressed: _nextQuestion,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                ),
                child: Text(
                  _currentIndex < _questions.length - 1
                      ? 'Next Question'
                      : 'Finish Quiz',
                  style: const TextStyle(fontSize: 18),
                ),
              ),
          ],
        ),
      ),
    );
  }
}