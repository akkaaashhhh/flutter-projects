import 'package:flutter/material.dart';

import 'package:financeapp/widgets/expenses.dart';

var kColorScheme =
    ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 18, 165, 131));

void main() {
  runApp(
    MaterialApp(
      theme: ThemeData().copyWith(
          useMaterial3: true,
          colorScheme: kColorScheme,
          appBarTheme: const AppBarTheme().copyWith(
              backgroundColor: kColorScheme.onPrimaryContainer,
              foregroundColor: kColorScheme.primaryContainer),
          cardTheme: const CardTheme().copyWith(
              color: kColorScheme.secondaryContainer,
              margin: const EdgeInsets.fromLTRB(5, 10, 5, 10)),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
                backgroundColor: kColorScheme.primaryContainer),
          ),
          textTheme: ThemeData().textTheme.copyWith(
                titleLarge: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: kColorScheme.onSecondaryContainer,
                    fontSize: 20),
              )),
      home: const Expenses(),
    ),
  );
}
