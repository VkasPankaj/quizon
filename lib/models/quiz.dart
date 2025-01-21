class Quiz {
  final int id;
  final String title;
  final String description;
  final List<Question> questions;

  Quiz({
    required this.id,
    required this.title,
    required this.description,
    required this.questions,
  });

  factory Quiz.fromJson(Map<String, dynamic> json) {
    return Quiz(
      id: json['id'],
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      questions: (json['questions'] as List)
          .map((question) => Question.fromJson(question))
          .toList(),
    );
  }
}

class Question {
  final int id;
  final String description;
  final List<Option> options;
  final int? correctOptionId;

  Question({
    required this.id,
    required this.description,
    required this.options,
    this.correctOptionId,
  });

  factory Question.fromJson(Map<String, dynamic> json) {
    return Question(
      id: json['id'],
      description: json['description'] ?? '',
      options: (json['options'] as List)
          .map((option) => Option.fromJson(option))
          .toList(),
      correctOptionId: json['correctOptionId'],
    );
}
}

class Option {
  final int id;
  final String description;
  final bool isCorrect;

  Option({
    required this.id,
    required this.description,
    required this.isCorrect,
  });

  factory Option.fromJson(Map<String, dynamic> json) {
    return Option(
      id: json['id'],
      description: json['description'] ?? '',
      isCorrect: json['is_correct'] ?? false,
    );
  }
}
