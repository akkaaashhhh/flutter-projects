import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shopping_list/data/categories.dart';
import 'package:shopping_list/models/category.dart';
import 'package:shopping_list/models/grocery_item.dart';
import 'package:http/http.dart' as http;

class NewItem extends StatefulWidget {
  const NewItem({super.key});

  @override
  State<NewItem> createState() {
    return _NewItemState();
  }
}

class _NewItemState extends State<NewItem> {
  final _formkey = GlobalKey<FormState>();

  void _saveItem() async {
    if (_formkey.currentState!.validate()) {
      _formkey.currentState!.save();
      setState(() {
        _isSending = true;
      });
      final url = Uri.https('shopping-list-7ed2e-default-rtdb.firebaseio.com',
          'shopping-list.json');
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
        body: json.encode(
          {
            'name': _enteredname,
            'quantity': _enteredqty,
            'category': _selectedcategory.title
          },
        ),
      );

      final Map<String, dynamic> resData = json.decode(response.body);
      if (!context.mounted) return null;
      Navigator.of(context).pop(GroceryItem(
          id: resData['name'],
          name: _enteredname,
          quantity: _enteredqty,
          category: _selectedcategory));
    }
  }

  var _enteredname;
  var _enteredqty = 1;
  var _selectedcategory = categories[Categories.vegetables]!;
  var _isSending = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('add new item'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Form(
          key: _formkey,
          child: Column(
            children: [
              TextFormField(
                maxLength: 50,
                decoration: const InputDecoration(
                  label: Text('Name'),
                ),
                validator: (value) {
                  if (value == null ||
                      value.isEmpty ||
                      value.trim().length <= 2 ||
                      value.trim().length > 50) {
                    return 'Must be between 2 and 50 characters long';
                  }
                  return null;
                },
                onSaved: (value) {
                  if (value == null) return;
                  _enteredname = value;
                },
              ), // instead of TextField for normal ones
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Expanded(
                    child: TextFormField(
                      decoration: const InputDecoration(
                        label: Text('Quantity'),
                      ),
                      keyboardType: TextInputType.number,
                      initialValue: _enteredqty.toString(),
                      validator: (value) {
                        if (value == null ||
                            value.isEmpty ||
                            int.tryParse(value)! > 999 ||
                            int.tryParse(value)! <= 0) {
                          return 'Must be a valid positive number between 0 and 999';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _enteredqty = int.parse(value!);
                      },
                    ),
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  Expanded(
                    child: DropdownButtonFormField(
                      value: _selectedcategory,
                      items: [
                        for (final category in categories.entries)
                          DropdownMenuItem(
                            value: category.value,
                            child: Row(
                              children: [
                                Container(
                                  width: 16,
                                  height: 16,
                                  color: category.value.color,
                                ),
                                const SizedBox(
                                  width: 6,
                                ),
                                Text(category.value.title),
                              ],
                            ),
                          )
                      ],
                      onChanged: (value) {
                        setState(() {
                          _selectedcategory = value!;
                        });
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  TextButton(
                      onPressed: _isSending
                          ? null
                          : () {
                              _formkey.currentState!.reset();
                            },
                      child: const Text('Reset')),
                  const SizedBox(
                    width: 24,
                  ),
                  ElevatedButton(
                      onPressed: _isSending ? null : _saveItem,
                      child: _isSending
                          ? Row(
                              children: const [
                                Text('Adding'),
                                SizedBox(
                                  width: 8,
                                ),
                                SizedBox(
                                  width: 16,
                                  height: 16,
                                  child: CircularProgressIndicator(),
                                )
                              ],
                            )
                          : const Text('Add'))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
