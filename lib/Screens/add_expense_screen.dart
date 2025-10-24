import 'package:expense_tracker_app/models/Expense_model.dart';
import 'package:flutter/material.dart';

class AddExpense extends StatefulWidget {
  const AddExpense({super.key});

  @override
  State<AddExpense> createState() => _AddExpenseState();
}

class _AddExpenseState extends State<AddExpense> {
  final TextEditingController _tittleController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  DateTime? _selectedDate;

  void showDatepicker() async {
    final pickedDate = await showDatePicker(
      context: context,
      firstDate: DateTime(2020),
      lastDate: DateTime.now(),
      initialDate: _selectedDate == null ? DateTime.now() : _selectedDate,
    );

    if (pickedDate != null) {
      setState(() {
        _selectedDate = pickedDate;
      });
    }
  }

  void submitForm() {
    if ((_formKey.currentState?.validate() ?? false) && _selectedDate != null) {
      final title = _tittleController.text;
      final amount = double.parse(_amountController.text);
      // final newExpense = {
      //   "Product": title,
      //   "Amount": amount,
      //   "Date": _selectedDate,
      // };
      final newExpense = ExpenseModel(
        title: title,
        amount: amount,
        date: _selectedDate,
      );
      Navigator.pop(context, newExpense);

      // print("Product : $title , Amount : $amount ,Date:$_selectedDate");
    }
  }

  void resetForm() {
    _formKey.currentState?.reset();
    _tittleController.clear();
    _amountController.clear();
    setState(() {
      _selectedDate = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurpleAccent,
        title: Text("Add Expense", style: TextStyle(color: Colors.white)),
      ),
      body: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,

          children: [
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: TextFormField(
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Plaese Enter the Product";
                  }
                  return null;
                },
                controller: _tittleController,
                decoration: InputDecoration(
                  labelText: "Product",
                  hintText: "Enter the Product",
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(15.0),
              child: TextFormField(
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return " Please Enter the Amount";
                  }
                  if (double.tryParse(value) == null || value.isEmpty) {
                    return " Please Enter the number";
                  }
                  return null;
                },
                keyboardType: TextInputType.number,
                controller: _amountController,
                decoration: InputDecoration(
                  labelText: "Amount",
                  hintText: "Enter the Amount",
                ),
              ),
            ),
            Text(
              _selectedDate == null
                  ? "No Date chosen"
                  : "Picked Date : ${_selectedDate!.day}/${_selectedDate!.month}/${_selectedDate!.year}",
            ),
            SizedBox(height: 25),

            TextButton(
              onPressed: () => showDatepicker(),
              child: Text(
                "Select Date",
                style: TextStyle(color: Colors.deepPurple, fontSize: 18),
              ),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.deepPurpleAccent,
                  ),
                  onPressed: () => submitForm(),
                  child: Text("Add Expense"),
                ),
                SizedBox(width: 20),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.red,
                  ),
                  onPressed: () => resetForm(),
                  child: Text("Reset"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
