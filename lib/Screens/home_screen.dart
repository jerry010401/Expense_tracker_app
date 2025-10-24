import 'package:expense_tracker_app/models/Expense_model.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // List<ExpenseModel> expenses = [
  //   ExpenseModel(title: "Groceries", amount: 350, date: DateTime.now()),
  //   ExpenseModel(
  //     title: "Foods",
  //     amount: 400,
  //     date: DateTime.now().subtract(Duration(days: 1)),
  //   ),
  // ];

  confirmDelete(index) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Delete Expense"),
        content: Text("Are you sure want to delete"),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text("cancel"),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
            ),
            onPressed: () async {
              final expenseBox = Hive.box<ExpenseModel>("expenses");
              await expenseBox.deleteAt(index);

              setState(() {
                Navigator.pop(context);
              });
            },
            child: Text("Delete"),
          ),
        ],
      ),
    );
  }

  final expenseBox = Hive.box<ExpenseModel>("expenses");
  List<ExpenseModel> get expenses => expenseBox.values.toList();

  final double totalBudget = 6000;
  double get totalExpense =>
      expenses.fold(0.0, (sum, item) => sum + item.amount);
  double get balance => totalBudget - totalExpense;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        foregroundColor: Colors.white,
        backgroundColor: Colors.deepPurpleAccent,
        child: Icon(Icons.add),
        onPressed: () async {
          final newExpense =
              await Navigator.pushNamed(context, "/add Expense")
                  as ExpenseModel;
          setState(() {
            // expenses.add(newExpense);
            expenseBox.add(newExpense);
          });
        },
      ),
      appBar: AppBar(
        backgroundColor: Colors.deepPurpleAccent,
        title: Text(
          "Expense Tracker App",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text.rich(
                    TextSpan(
                      text: "Total Expenses: ",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                      children: [
                        TextSpan(
                          text: totalExpense.toStringAsFixed(2),
                          style: TextStyle(fontSize: 15, color: Colors.red),
                        ),
                      ],
                    ),
                  ),
                  Text.rich(
                    TextSpan(
                      text: "Balance: ",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                      children: [
                        TextSpan(
                          text: balance.toStringAsFixed(2),
                          style: TextStyle(fontSize: 15, color: Colors.green),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          Expanded(
            child: ListView.builder(
              itemCount: expenses.length,
              itemBuilder: (context, index) {
                final expense = expenses[index];
                return ExpenseCard(
                  title: expense.title,
                  date: expense.date,
                  amount: expense.amount,
                  onDelete: () => confirmDelete(index),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class ExpenseCard extends StatelessWidget {
  final String title;
  final DateTime? date;
  final double amount;
  final VoidCallback onDelete;
  const ExpenseCard({
    super.key,
    required this.title,
    required this.date,
    required this.amount,
    required this.onDelete,
  });

  String get formattedDate {
    return date == null ? "No date" : DateFormat("MMM d, y").format(date!);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.deepPurpleAccent,
      margin: EdgeInsets.all(10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,

        children: [
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      title.length > 10
                          ? "${title.substring(0, 10)}...."
                          : title,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 5),

                    Text(formattedDate, style: TextStyle(color: Colors.white)),
                  ],
                ),
              ),
            ],
          ),
          Container(
            decoration: BoxDecoration(
              border: BoxBorder.all(color: Colors.white, width: 2),
              borderRadius: BorderRadius.circular(5),
            ),
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            child: Text(
              amount.toStringAsFixed(2),
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
          ),
          IconButton(
            onPressed: onDelete,
            icon: Icon(Icons.delete, color: Colors.red),
          ),
        ],
      ),
    );
  }
}
