import 'package:http/http.dart' as http;
import './question_model.dart';
import 'dart:convert';

class DBconnect {
  final url = Uri.parse(
      'https://edu-mobile-d35dd-default-rtdb.firebaseio.com/questions.json');

  /*Future<void> addQuestion(Question question) async {
    http.post(url,
        body: json.encode({
          'title': question.title,
          'options': question.options,
        }));
  }*/

//fetch the data from database
  Future<List<Question>> fetchQuestions() async {
    final response = await http.get(url);

    if (response.statusCode != 200) {
      print('Error fetching data: ${response.statusCode}');
      return [];
    }

    final data = json.decode(response.body) as Map<String, dynamic>?;

    if (data == null) {
      print('No data received from the server.');
      return [];
    }

    List<Question> newQuestions = [];
    data.forEach((key, value) {
      var newQuestion = Question(
        id: key,
        title: value['title'],
        options: Map.castFrom(value['options']),
      );
      newQuestions.add(newQuestion);
    });

    return newQuestions;
  }
}
