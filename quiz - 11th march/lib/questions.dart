import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class Questions extends StatelessWidget {
  String qtext;

  Questions(this.qtext);

  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        margin: EdgeInsets.fromLTRB(150, 100, 0, 100),
        child: Text(
          qtext,
        ));
  }
}
