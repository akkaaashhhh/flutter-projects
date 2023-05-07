import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:intl/intl.dart';

final datetostring = DateFormat.yMd(); //special function to format date

const uuid = Uuid();

enum Category { food, travel, leisure, work }

// we use an enum because if the category is passed as a string it can have typos and we wouldn't even know

const categoryIcons = {
  Category.food: Icons.lunch_dining,
  Category.travel: Icons.flight_takeoff,
  Category.leisure: Icons.movie,
  Category.work: Icons.work,
};

class Expense {
  Expense(
      {required this.title,
      required this.amount,
      required this.date,
      required this.category})
      : id = uuid
            .v4(); //the uuid is an external package for generating unique id each time it is called
  final String id;
  final String title;
  final double amount;
  final DateTime date; //special datatype in dart
  final Category category;

  String get dateformat {
    return datetostring.format(date);
  }
}
