import 'package:expense_tracker_app/Screens/add_expense_screen.dart';
import 'package:expense_tracker_app/Screens/home_screen.dart';
import 'package:expense_tracker_app/models/Expense_model.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final appDocDir = await getApplicationDocumentsDirectory();
  Hive.init(appDocDir.path);
  Hive.registerAdapter(ExpenseModelAdapter());
  await Hive.openBox<ExpenseModel>("expenses");
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primaryColor: Colors.deepPurpleAccent),

      routes: {
        "/": (context) => HomeScreen(),
        "/add Expense": (context) => AddExpense(),
      },
    );
  }
}
