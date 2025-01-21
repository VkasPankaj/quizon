import 'dart:convert';
import 'package:http/http.dart' as http;

class QuizService {
  static const String _baseUrl = "https://api.jsonserve.com/Uw5CrX";

  Future<Map<String, dynamic>> fetchQuizData() async {
    print("gffg");
    final response = await http.get(Uri.parse(_baseUrl));

    if (response.statusCode == 200) {
      print("hhhhh");
      return jsonDecode(response.body);
    } else {
      print("kkkkk");
      throw Exception('Failed to load quiz');
    }
  }
}