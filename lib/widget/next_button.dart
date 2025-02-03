import 'package:flutter/material.dart';
import '../constants.dart';

class NextButton extends StatelessWidget {
  const NextButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
          color: Color(0xFF674AEF), borderRadius: BorderRadius.circular(10.0)),
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: const Text(
        'Next Question',
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 20.0,color: Colors.white,fontWeight: FontWeight.bold) ,
      ),
    );
  }
}
