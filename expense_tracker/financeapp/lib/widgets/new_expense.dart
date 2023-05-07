import 'package:flutter/material.dart';
import 'package:financeapp/models/expense.dart';

class NewExpense extends StatefulWidget {
  const NewExpense({super.key, required this.onAddExpense});

  final void Function(Expense expense) onAddExpense;
  @override
  State<NewExpense> createState() {
    return _NewExpenseState();
  }
}

class _NewExpenseState extends State<NewExpense> {
  // var enteredTitle = '';

  // void _saveTitleInput(String inputValue) {
  //   enteredTitle = inputValue;
  // }

  final titleController = TextEditingController();
  final amountcontroller = TextEditingController();
  DateTime? _pickedDate;
  Category _selectedCategory = Category.leisure;

  void _datepicker() async {
    final now = DateTime.now();
    final chosendate = await showDatePicker(
        context: context,
        initialDate: now,
        firstDate: DateTime(now.year - 1, now.month, now.day),
        lastDate: DateTime(now.year + 1, now.month, now.day));
    setState(() {
      _pickedDate = chosendate;
    });
  }

  void _submitExpenseData() {
    final enteredamount = double.tryParse(amountcontroller.text);
    if (titleController.text.trim().isEmpty ||
        enteredamount == null ||
        enteredamount <= 0 ||
        _pickedDate == null) {
      //show error message
      showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
                title: const Text('invalid input'),
                content: const Text('enter all the required details'),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(ctx);
                    },
                    child: const Text('okay'),
                  )
                ],
              ));
      return;
    }
    widget.onAddExpense(Expense(
        title: titleController.text,
        amount: enteredamount,
        date: _pickedDate!,
        category: _selectedCategory));
    Navigator.pop(context);
  }

  @override
  void dispose() {
    titleController.dispose();
    amountcontroller.dispose();
    super.dispose();
  }
  // the dispose method for the texteditingcontroller is important because the editingcontroller keeps on storing into the memory and wasting it even after the modal or the intended functionality is closed

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(16, 48, 16, 16),
      child: Column(
        children: [
          TextField(
            controller: titleController,
            decoration:
                const InputDecoration(label: const Text('Expense name')),
          ),
          Row(
            children: [
              // the textfield and the row inside the children are put in expanded because textfield usually tries to take up as much space as possible and a row cant be placed inside a row
              Expanded(
                  child: TextField(
                controller: amountcontroller,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                    prefixText: '\$', label: Text('Amount')),
              )),
              const SizedBox(
                width: 16,
              ),
              Expanded(
                  child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(_pickedDate == null
                      ? 'No date selected'
                      : datetostring.format(
                          _pickedDate!)), // the exclamation mark at the end is necessary to force dart to assume that the pickeddate is not NULL as that is what is being checked earlier
                  IconButton(
                      onPressed: _datepicker,
                      icon: const Icon(Icons.calendar_month))
                ],
              ))
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              DropdownButton(
                  value: _selectedCategory,
                  items: Category.values
                      .map((category) => DropdownMenuItem(
                          value: category,
                          child: Text(category.name.toUpperCase())))
                      .toList(),
                  onChanged: (value) {
                    if (value == null) {
                      return;
                    } else {
                      setState(() {
                        _selectedCategory = value;
                      });
                    }
                  }),
              const Spacer(),
              ElevatedButton(
                  onPressed: _submitExpenseData,
                  child: const Text('Add to Expenses')),
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('Cancel'))
            ],
          )
        ],
      ),
    );
  }
}
