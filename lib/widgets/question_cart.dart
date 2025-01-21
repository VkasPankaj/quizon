import 'package:flutter/material.dart';
import '../models/quiz.dart';

class QuestionCard extends StatelessWidget {
  final Question question;

  const QuestionCard({super.key, required this.question});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8.0),
      child: ListTile(
        title: Text(question.description),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: question.options
              .map((option) => Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4.0),
                    child: Text(option.description),
                  ))
              .toList(),
        ),
      ),
    );
  }
}
