import 'package:flutter/material.dart';

class Questions extends StatelessWidget {
  final String qtext; // because this variable should not be changed internally

  Questions(this.qtext);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double
          .infinity, // given in order to make sure that the container elements take up maximum space , which also makes the container centered
      margin: EdgeInsets.all(10),
      child: Text(qtext,
          style: TextStyle(fontSize: 28), textAlign: TextAlign.center),
    );
  }
}
