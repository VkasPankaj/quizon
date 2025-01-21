import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/quiz_provider.dart';

class ResultScreen extends StatelessWidget {
  final List<bool> results;

  const ResultScreen({super.key, required this.results});

  @override
  Widget build(BuildContext context) {
    final quizProvider = Provider.of<QuizProvider>(context);
    final totalQuestions = quizProvider.quiz!.questions.length;
    final correctAnswers = results.where((result) => result).length;
    final scorePercentage = (correctAnswers / totalQuestions) * 100;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Results',
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.teal,
      ),
      body: Column(
        children: [
          // Score Section
          Container(
            padding: const EdgeInsets.all(20),
            color: Colors.teal.withOpacity(0.1),
            child: Column(
              children: [
                const Text(
                  'Your Score',
                  style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.teal),
                ),
                const SizedBox(height: 10),
                Text(
                  '$correctAnswers / $totalQuestions',
                  style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black87),
                ),
                const SizedBox(height: 10),
                Text(
                  '${scorePercentage.toStringAsFixed(1)}%',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: scorePercentage >= 50 ? Colors.green : Colors.red,
                  ),
                ),
              ],
            ),
          ),

          // Results List
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: totalQuestions,
              itemBuilder: (context, index) {
                final question = quizProvider.quiz!.questions[index];
                final userAnswerIndex = quizProvider.userselect[index];
                final correctOption = question.options.firstWhere((option) => option.isCorrect);
                final userAnswer = userAnswerIndex != -1 ? question.options[userAnswerIndex] : null;
                final isCorrect = results[index];

                return Card(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  elevation: 4,
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Question Number and Text
                        Row(
                          children: [
                            CircleAvatar(
                              radius: 18,
                              backgroundColor: isCorrect ? Colors.green : Colors.red,
                              child: Text(
                                '${index + 1}',
                                style: const TextStyle(color: Colors.white),
                              ),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: Text(
                                question.description,
                                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),

                        // User Answer
                        Text(
                          "Your answer: ${userAnswer != null ? userAnswer.description : "Not answered"}",
                          style: TextStyle(
                            fontSize: 14,
                            color: userAnswer != null && isCorrect ? Colors.green : Colors.red,
                          ),
                        ),

                        // Correct Answer
                        Text(
                          "Correct answer: ${correctOption.description}",
                          style: const TextStyle(fontSize: 14, color: Colors.green),
                        ),

                        // Result Indicator
                        Align(
                          alignment: Alignment.centerRight,
                          child: Chip(
                            label: Text(
                              isCorrect ? "Correct" : "Wrong",
                              style: const TextStyle(color: Colors.white),
                            ),
                            backgroundColor: isCorrect ? Colors.green : Colors.red,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),

          // Action Buttons
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton.icon(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(Icons.home),
                  label: const Text('Home'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.teal,
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  ),
                ),
                ElevatedButton.icon(
                  onPressed: () {
                    // Restart or retry functionality
                  },
                  icon: const Icon(Icons.refresh),
                  label: const Text('Retry'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange,
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
