QuizOn

QuizOn is a Flutter-based quiz application that provides an engaging and modern platform for users to take quizzes and evaluate their knowledge. It implements gamification techniques to make the quiz experience enjoyable and rewarding. The app uses the Provider package for state management and is designed with a minimalistic and modern UI/UX.

Features

Dynamic Quiz Loading: Fetch quizzes dynamically from an external source.

User-Friendly Interface: Modern UI/UX with a clean and minimalistic design.

Gamification: Color-coded feedback, score tracking, and progress indicators.

Result Evaluation: Detailed results page with correct and incorrect answers highlighted.

Retry and Replay: Options to retake quizzes or return to the main menu.

Screens

1. Quiz Screen

Displays a list of questions and multiple-choice options.

Users can select an answer for each question using radio buttons.

Includes a submit button to evaluate results.

2. Result Screen

Displays the user's score and percentage.

Shows the user's answers, correct answers, and feedback for each question.

Includes buttons for retrying the quiz or returning to the home screen.

Project Structure

lib/
|-- models/
|   |-- quiz.dart         # Data model for quizzes
|
|-- providers/
|   |-- quiz_provider.dart # State management logic using Provider
|
|-- screens/
|   |-- quiz_screen.dart   # Main quiz interface
|   |-- result_screen.dart # Result and feedback screen
    |-- quiz_screen.dart  
|
|-- services/
|   |-- quiz_services.dart # Service to fetch quiz data
|
|-- main.dart             # Application entry point

Technologies Used

Flutter: Framework for building the UI.

Dart: Programming language for Flutter development.

Provider: State management solution.

Material Design: UI components and theming.
