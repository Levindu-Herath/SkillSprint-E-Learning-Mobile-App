import 'dart:async';
import 'package:edu_app/widget/next_button.dart';
import 'package:edu_app/widget/option_card.dart';
import 'package:edu_app/widget/question_wiget.dart';
import 'package:edu_app/widget/result_box.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import '../constants.dart';
import '../models/question_model.dart';

import '../models/db_connect.dart';

//homeScreen widget
class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  //Dbconnect object
  var db = DBconnect();
  /*List<Question> _questions = [
    Question(
      id: '10',
      title: 'What is 2+2 ?',
      options: {'5': false, '30': false, '4': true, '10': false},
    ),
    Question(
      id: '11',
      title: 'What is 10+20 ?',
      options: {'50': false, '30': true, '4': false, '10': false},
    )
  ];
*/

  late Future _questions;

  Future<List<Question>> getData() async {
    return db.fetchQuestions();
  }

  @override
  void initState() {
    _questions = getData();
    super.initState();
  }

  //index to loop through questions
  int index = 0;
  //initial score
  int score = 0;
  //check if user has clicked
  bool isPressed = false;

  //display next question
  bool isAlreadySlected = false;
  void nextQuestion(int questionLength) {
    if (index == questionLength - 1) {
      showDialog(
          context: context,
          barrierDismissible:
          false, //disable the dissmis function on clicking outside of the box
          builder: (ctx) => ResultBox(
            result: score, //total score of the student
            questionLength: questionLength,
            onPressed: startOver,
          ));
    } else {
      if (isPressed) {
        setState(() {
          index++;
          isPressed = false;
          isAlreadySlected = false;
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('please select any option'),
          behavior: SnackBarBehavior.floating,
          margin: EdgeInsets.symmetric(vertical: 20.0),
        ));
      }
    }
  }

//function for changing color
  void checkAnswerAndUpdate(bool value) {
    if (isAlreadySlected) {
      return;
    } else {
      if (value == true) {
        score++;
      }
      setState(() {
        isPressed = true;
        isAlreadySlected = true;
      });
    }
  }

  void startOver() {
    setState(() {
      index = 0;
      score = 0;
      isPressed = false;
      isAlreadySlected = false;
    });
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    //use the futureBuilder Widget
    return FutureBuilder(
      future: _questions as Future<List<Question>>,
      builder: (ctx, snaphot) {
        if (snaphot.connectionState == ConnectionState.done) {
          if (snaphot.hasError) {
            return Center(
              child: Text('${snaphot.error}'),
            );
          } else if (snaphot.hasData) {
            var extractedData = snaphot.data as List<Question>;
            return Scaffold(
              backgroundColor: background,
              appBar: AppBar(
                title: const Text('Quiz App',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 22,color: Colors.black54),),
                backgroundColor: background,
                shadowColor: Colors.transparent,
                actions: [
                  Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: Text(
                      'Score: $score',
                      style: const TextStyle(fontSize: 20.0, color: Colors.black45,fontWeight: FontWeight.bold),
                    ),
                  )
                ],
              ),
              body: Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Column(
                  children: [
                    //questionWidget
                    QuestionWiget(
                      indexAction: index, //currently at 0
                      question: extractedData[index]
                          .title, // first question in the list
                      totalQuestions:
                      extractedData.length, // total length of the list
                    ),
                    const Divider(color: Colors.black38),
                    const SizedBox(
                      height: 25.0,
                    ),
                    for (int i = 0;
                    i < extractedData[index].options.length;
                    i++)
                      GestureDetector(
                        onTap: () => checkAnswerAndUpdate(
                            extractedData[index].options.values.toList()[i]),
                        child: OptionCard(
                          option: extractedData[index].options.keys.toList()[i],
                          color: isPressed
                              ? extractedData[index]
                              .options
                              .values
                              .toList()[i] ==
                              true
                              ? correct
                              : incorrect
                              : neutral,
                        ),
                      ),
                  ],
                ),
              ),
              //floating action button
              floatingActionButton: GestureDetector(
                onTap: () => nextQuestion(extractedData.length),
                child: const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.0),
                  child: NextButton(),
                ),
              ),
              floatingActionButtonLocation:
              FloatingActionButtonLocation.centerFloat,
            );
          }
        } else {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const CircularProgressIndicator(),
                const SizedBox(height: 20.0),
                Text(
                  'Please Wait While Questions are Loading...',
                  style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    decoration: TextDecoration.none,
                    fontSize: 14.0,
                  ),
                ),
              ],
            ),
          );
        }
        return const Center(
          child: Text('No Data'),
        );
      },
    );
  }
}
