import 'package:edu_app/constants.dart';
import 'package:flutter/material.dart';


class QuestionWiget extends StatelessWidget {
  const QuestionWiget(
      {Key? key,
      required this.question,
      required this.indexAction,
      required this.totalQuestions})
      : super(key: key);

//question title and total number of questions
  final String question;
  final int indexAction;
  final int totalQuestions;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      child: Text(
        'Question ${indexAction + 1}/$totalQuestions: $question',
        style: const TextStyle(
          fontSize: 21.0,
          color: Colors.black,
          fontWeight: FontWeight.bold

        ),
      ),
    );
  }
}
