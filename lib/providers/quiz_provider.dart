import 'package:flutter/material.dart';
import '../models/quiz.dart';
import '../services/quiz_services.dart';

class QuizProvider with ChangeNotifier {
  Quiz? _quiz;
  bool _isLoading = false;
  bool _isQuizFetched = false;
  late List<Option> userAnswers; // User-selected answers
  late List<int> userselect; // Selected option indices
  List<Option> rightanswer = []; // List of correct answers

  Quiz? get quiz => _quiz;
  bool get isLoading => _isLoading;
  bool get isQuizFetched => _isQuizFetched;

  // Fetch the quiz data and initialize state
  Future<void> fetchQuiz() async {
    if (_isQuizFetched) return; // Avoid redundant fetch
    _isLoading = true;

    try {
      final data = await QuizService().fetchQuizData();
      _quiz = Quiz.fromJson(data);

      // Initialize user answers and selections based on quiz questions
      final questionCount = _quiz!.questions.length;
      userAnswers = List<Option>.generate(
        questionCount,
        (_) => Option(id: -1, description: '', isCorrect: false),
      );
      userselect = List<int>.generate(
        questionCount,
        (_) => -1,
      );

      _isQuizFetched = true;
    } catch (e) {
      print("Error fetching quiz: $e");
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

 void selectAnswer(int questionIndex, int optionIndex, Option op) {
  if (userAnswers[questionIndex] != op || userselect[questionIndex] != optionIndex) {
    userAnswers[questionIndex] = op;
    userselect[questionIndex] = optionIndex;

    if (op.isCorrect && !rightanswer.contains(op)) {
      rightanswer.add(op);
    }

    notifyListeners();
  }
}


  // Get the results of the quiz
  List<bool> getResults() {
    return List<bool>.generate(
      _quiz!.questions.length,
      (index) {
        final userAnswer = userAnswers[index];
        return userAnswer.isCorrect;
      },
    );
  }

  
}
