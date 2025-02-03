import 'package:edu_app/screens/bottomnavigation.dart';
import 'package:edu_app/screens/home_screen.dart';
import 'package:flutter/material.dart';
import '../constants.dart';

class ResultBox extends StatelessWidget {
  const ResultBox({
    Key? key,
    required this.result,
    required this.questionLength,
    required this.onPressed,
  }) : super(key: key);
  final int result;
  final int questionLength;
  final VoidCallback onPressed;
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: background,
      content: Padding(
        padding: const EdgeInsets.only(top: 30,left: 30,right: 30,bottom: 30),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Result',
              style: TextStyle(color: Colors.black45, fontSize: 24.0,fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20.0),
            CircleAvatar(
              child: Text(
                '$result/$questionLength',
                style: const TextStyle(fontSize: 30.0),
              ),
              radius: 70.0,
              backgroundColor: result == questionLength / 2
                  ? Colors.yellow
                  : result < questionLength / 2
                      ? incorrect
                      : correct,
            ),
            const SizedBox(
              height: 20.0,
            ),
            Text(
              result == questionLength / 2
                  ? 'Almost There'
                  : result < questionLength / 2
                      ? 'Try Again ?'
                      : 'Great!',
              style: const TextStyle(color: neutral),
            ),
            const SizedBox(
              height: 25.0,
            ),
            GestureDetector(
              onTap: onPressed,
              child: const Text(
                'Start Over',
                style: TextStyle(
                    color: Colors.blue, fontSize: 20.0, letterSpacing: 1.0,fontWeight: FontWeight.w500),
              ),
            ),
            const SizedBox(
              height: 30.0,
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => BottomNav()), // Navigate to HomePage
                );
              },
              child: const Text(
                'Go To Home',
                style: TextStyle(
                  color: Colors.blueAccent,
                  fontWeight: FontWeight.bold,
                  fontSize: 20.0,
                  letterSpacing: 1.0,
                ),
              ),
            ),

          ],
        ),
      ),
    );
  }
}
