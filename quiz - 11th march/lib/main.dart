import 'package:flutter/material.dart';
import './questions.dart';
import './answer.dart';

void main() {
  runApp(Quizapp());
}

class Quizapp extends StatefulWidget {
  const Quizapp({super.key});

  @override
  State<Quizapp> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<Quizapp> {
  var questions = [
    {
      'qtext': 'who won the world cup',
      'answer': [
        {'text': 'argentina', 'score': 5},
        {'text': 'france', 'score': 0},
        {'text': 'england', 'score': 0}
      ]
    },
    {
      'qtext': 'Who is the GOAT?',
      'answer': [
        {'text': 'Messi', 'score': 5},
        {'text': 'siu', 'score': 0},
        {'text': 'mbappe', 'score': 0}
      ]
    }
  ];

  var totalscore = 0;
  var qindex = 0;
  void answerq(int score) {
    totalscore += score;
    setState(() {
      qindex++;
    });
  }

  void reset() {
    setState(() {
      qindex = 0;
      totalscore = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
            body: qindex < questions.length
                ? Container(
                    width: double.infinity,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Questions(questions[qindex]['qtext'] as String),
                        ...(questions[qindex]['answer']
                                as List<Map<String, Object>>)
                            .map((answer) {
                          return Answer(() => answerq(answer['score'] as int),
                              answer['text'] as String);
                        }),
                      ],
                    ))
                : Container(
                    width: double.infinity,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                            "you have completed the quiz with a score of ${totalscore}!"),
                        ElevatedButton(onPressed: reset, child: Text('restart'))
                      ],
                    ))));
  }
}
