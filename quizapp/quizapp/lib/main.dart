import 'package:flutter/material.dart';

import './quiz.dart';

import './answer.dart';

import './result.dart';

void main() => runApp(QuizApp());

class QuizApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return QuizAppState();
  }
}

class QuizAppState extends State<QuizApp> {
  @override
  var qindex = 0;
  var totalscore = 0;

  void reset() {
    setState(() {
      qindex = 0;
      totalscore = 0;
    });
  }

  void answer(int score) {
    totalscore += score;
    setState(() {
      qindex = (qindex + 1);
    });
    print(qindex);
  }

  static const questions = [
    {
      'qtext': 'Who won the world cup this year ? ',
      'answers': [
        {'Text': 'Argentina', 'score': 5},
        {'Text': 'Portugal', 'score': 0},
        {'Text': 'Brazil', 'score': 0}
      ]
    },
    {
      'qtext': 'Who won the best golden boot ? ',
      'answers': [
        {'Text': 'Mbappe', 'score': 5},
        {'Text': 'Messi', 'score': 0},
        {'Text': 'Ronaldo', 'score': 0},
      ]
    },
    {
      'qtext': 'Who won the best young player award ? ',
      'answers': [
        {'Text': 'alvarez', 'score': 0},
        {'Text': 'Enzo', 'score': 5},
        {'Text': 'bellingham', 'score': 0},
      ]
    },
  ];

  @override
  Widget build(BuildContext item1) {
    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(
            title: Text('Quiz App'),
          ),
          body: qindex < questions.length
              ? Quiz(questions, answer, qindex)
              : Result(totalscore, reset)),
    );
  }
}
