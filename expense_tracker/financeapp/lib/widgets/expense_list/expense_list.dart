import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:financeapp/models/expense.dart';
import 'package:financeapp/widgets/expense_list/expense_item.dart';

class ExpenseList extends StatelessWidget {
  const ExpenseList({
    super.key,
    required this.expenses,
    required this.onRemoveExpense,
  });

  final List<Expense> expenses;
  final void Function(Expense expense) onRemoveExpense;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: expenses.length,
        itemBuilder: (ctx, index) => Dismissible(
            key: ValueKey(expenses[index]),
            background: Container(
              color: Theme.of(context).colorScheme.error,
            ),
            onDismissed: (direction) {
              onRemoveExpense(expenses[index]);
            },
            child: ExpenseItem(expenses[
                index]))); //columns cant be used because the length is unknown
  }
}
