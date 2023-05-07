import 'package:financeapp/widgets/new_expense.dart';
import 'package:flutter/material.dart';
import 'package:financeapp/models/expense.dart';
import 'package:financeapp/widgets/expense_list/expense_list.dart';

class Expenses extends StatefulWidget {
  const Expenses({super.key});
  @override
  State<Expenses> createState() {
    return _ExpensesState();
  }
}

class _ExpensesState extends State<Expenses> {
  final List<Expense> _registeredExpenses = [];

  void _openmodal() {
    showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (ctx) => NewExpense(onAddExpense: _addExpense));
  }

  void _addExpense(Expense expense) {
    setState(() {
      _registeredExpenses.add(expense);
    });
  }

  void _removeExpense(Expense expense) {
    final expindex = _registeredExpenses.indexOf(expense);
    setState(() {
      _registeredExpenses.remove(expense);
    });
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      duration: const Duration(seconds: 2),
      content: const Text('Expense deleted'),
      action: SnackBarAction(
          label: 'undo',
          onPressed: () {
            setState(() {
              _registeredExpenses.insert(expindex, expense);
            });
          }),
    ));
  }

  @override
  Widget build(BuildContext context) {
    Widget mainContent = const Center(child: Text('No Expenses to show'));
    if (_registeredExpenses.isNotEmpty) {
      mainContent = ExpenseList(
        expenses: _registeredExpenses,
        onRemoveExpense: _removeExpense,
      );
    }
    return Scaffold(
        appBar: AppBar(title: const Text('Expense Tracker'), actions: [
          IconButton(onPressed: _openmodal, icon: const Icon(Icons.add))
        ]),
        body: Padding(
          padding: const EdgeInsets.fromLTRB(8, 24, 8, 8),
          child: Column(
            children: [
              Expanded(child: mainContent),
            ],
          ),
        ));
  }
}
