import 'package:flutter/material.dart';

class Answer extends StatelessWidget {
  String answertext;
  VoidCallback answerselect;
  Answer(this.answerselect, this.answertext);

  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        child: ElevatedButton(
          child: Text(answertext),
          onPressed: answerselect,
        ));
  }
}
