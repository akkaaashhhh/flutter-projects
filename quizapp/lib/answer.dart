import 'package:flutter/material.dart';

class Answer extends StatelessWidget {
  final Function
      answerselect; // instead of function voidcallback can be used as well if an error arises
  final String answertext;
  Answer(this.answerselect, this.answertext);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: ElevatedButton(
        style: ButtonStyle(
            backgroundColor: MaterialStatePropertyAll(Colors.black38)),
        child: Text(answertext),
        onPressed:
            answerselect, // this function is passed onto this widget using a constructor of this widget
      ),
    );
  }
}
