import 'package:flutter/material.dart';

class Result extends StatelessWidget {
  final int score;
  final Function reset;

  Result(this.score, this.reset);

  String get resultphrase {
    var resulttxt;
    if (score > 10)
      resulttxt = 'That\'s amazing';
    else if (score > 5 && score <= 10)
      resulttxt =
          'That is a good score, Just a little more work and you will be doing wonders !';
    else
      resulttxt = 'You need to update yourself bro';

    return resulttxt;
  }

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(children: <Widget>[
      Text(
        'Your score is $score \n$resultphrase',
        style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
        textAlign: TextAlign.center,
      ),
      ElevatedButton(
        child: Text('Restart'),
        onPressed: reset,
      )
    ]));
  }
}
