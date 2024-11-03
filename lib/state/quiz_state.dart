import 'package:flutter/material.dart';

class QuizState extends ChangeNotifier {
  int _currentQuestionIndex = 0;
  int _score = 0;
  bool _isQuizFinished = false;

  int get currentQuestionIndex => _currentQuestionIndex;
  int get score => _score;
  bool get isQuizFinished => _isQuizFinished;

  void nextQuestion() {
    if (_currentQuestionIndex < questions.length - 1) {
      _currentQuestionIndex++;
      notifyListeners();
    } else {
      _isQuizFinished = true;
      notifyListeners();
    }
  }

  void answerQuestion(bool isCorrect) {
    if (isCorrect) {
      _score++;
    }
    notifyListeners();
  }

  void resetQuiz() {
    _currentQuestionIndex = 0;
    _score = 0;
    _isQuizFinished = false;
    notifyListeners();
  }

  // Sample questions (replace with your actual questions)
  final List<Map<String, dynamic>> questions = [
    {
      'questionText': 'What is the capital of France?',
      'answers': ['Berlin', 'Paris', 'Madrid', 'Rome'],
      'correctAnswerIndex': 1,
    },
    {
      'questionText': 'What is the highest mountain in the world?',
      'answers': ['K2', 'Kangchenjunga', 'Mount Everest', 'Lhotse'],
      'correctAnswerIndex': 2,
    },
    // Add more questions here
  ];
}
