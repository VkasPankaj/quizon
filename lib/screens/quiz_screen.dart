import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quizon/screens/result_screen.dart';
import '../providers/quiz_provider.dart';

class QuizScreen extends StatelessWidget {
  const QuizScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          'Quiz Challenge',
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600, color: Colors.black),
        ),
        elevation: 0,
      ),
      body: Consumer<QuizProvider>(
        builder: (context, quizProvider, child) {
          return FutureBuilder(
            future: quizProvider.isQuizFetched ? null : quizProvider.fetchQuiz(),
            builder: (context, snapshot) {
              if (quizProvider.isLoading) {
                return const Center(child: CircularProgressIndicator());
              }
              if (quizProvider.quiz == null) {
                return const Center(child: Text('No quiz available', style: TextStyle(fontSize: 18)));
              }
              return Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    Expanded(
                      child: ListView.builder(
                        itemCount: quizProvider.quiz!.questions.length,
                        itemBuilder: (context, index) {
                          final question = quizProvider.quiz!.questions[index];

                          // Ensure `userselect` has enough elements to prevent range errors
                          while (quizProvider.userselect.length <= index) {
                            quizProvider.userselect.add(-1); // Default value for unanswered questions
                          }

                          return Padding(
                            padding: const EdgeInsets.only(bottom: 16),
                            child: Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              margin: EdgeInsets.zero,
                              elevation: 4,
                              color: Colors.white,
                              child: Padding(
                                padding: const EdgeInsets.all(16),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    // Serial No. and Question Text
                                    Row(
                                      children: [
                                        Text(
                                          '${index + 1}.',
                                          style: const TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black,
                                          ),
                                        ),
                                        const SizedBox(width: 8),
                                        Expanded(
                                          child: Text(
                                            question.description,
                                            style: const TextStyle(
                                              fontSize: 16,
                                              color: Colors.black,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 10),
                                    
                                    // Options
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: question.options.asMap().entries.map(
                                        (entry) {
                                          final optionIndex = entry.key;
                                          final option = entry.value;
                                          return Padding(
                                            padding: const EdgeInsets.only(bottom: 8),
                                            child: RadioListTile<int>(
                                              title: Text(
                                                option.description,
                                                style: const TextStyle(
                                                  fontSize: 14,
                                                  color: Colors.black,
                                                ),
                                              ),
                                              value: optionIndex,
                                              groupValue: quizProvider.userselect[index],
                                              onChanged: (value) {
                                                quizProvider.selectAnswer(index, value!, option);
                                              },
                                              activeColor: Colors.blueGrey,
                                            ),
                                          );
                                        },
                                      ).toList(),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    // Submit Button
                    
                       ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blueGrey, // Modern minimal color
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          elevation: 5,
                        ),
                        onPressed: () {
                          final results = quizProvider.getResults();
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ResultScreen(results: results),
                            ),
                          );
                        },
                        child: const Text(
                          'Submit',
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                        ),
                      ),
                    
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
