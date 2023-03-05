import 'package:flutter/material.dart';

import './questions.dart';
import './answer.dart';

class Quiz extends StatelessWidget {
  final List<Map<String, Object>> questions;
  final Function answer;
  final int qindex;

  Quiz(this.questions, this.answer, this.qindex);
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Questions(questions[qindex]['qtext']),
        ...(questions[qindex]['answers'] as List<Map<String, Object>>)
            .map((answerlist) {
          // ... operator is called spread operator
          //the map converts each of the answer into a widget
          return Answer(
              () => answer(answerlist['score']), answerlist['Text']); //
        }).toList() // the toList function exists so as to convert the output (that is the widget for each of the answers in the list) that the map returns into a list
      ],
    );
  }
}
