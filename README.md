Expense Tracker App

A simple expense tracking mobile app built with Flutter. Uses Hive for local data storage, enabling offline‐first management of expenses.

🧾 Features

Add, edit, delete expense entries

Store data locally using Hive – no internet required

Categorise expenses (you may adapt categories to your app)

View list of expenses and summary (e.g., total spent)

Folder structure:

lib/models/ – your data models

lib/screens/ – UI screens

lib/… – other folders as needed (widgets, services, etc)

Designed for easy extension (e.g., add reports, graphs, sync later)

📁 Project Structure

Example folder structure:

lib/
 ├── main.dart
 ├── models/
 │    └── expense_model.dart
 ├── screens/
 │    ├── home_screen.dart
 │    ├── add_expense_screen.dart
 │    ├── edit_expense_screen.dart
 ├── services/
 │    └── hive_service.dart       // for Hive initialisation & operations
 ├── widgets/
 │    └── expense_item_tile.dart
 └── utils/
      └── constants.dart


You mentioned having Screens and models folders — adjust/expand as your code base demands.

🚀 Getting Started
Prerequisites

Flutter SDK installed

A device or emulator to run the app

Basic familiarity with Dart & Flutter

Installation

Clone this repository (or copy your project)

git clone <repo‐url>
cd expense_tracker_app


Open the project in your IDE (VS Code / Android Studio)

Get the dependencies:

flutter pub get


Initialise & open Hive boxes in main.dart (example):

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(ExpenseModelAdapter());
  await Hive.openBox<ExpenseModel>('expenses');
  runApp(MyApp());
}


(Adapt to your model & box name)

Medium
+2
FreeCodeCamp
+2

Run the app:

flutter run

💡 Usage

On launch, the home screen shows a list of expenses

Tap “+” (or similar) to add a new expense — enter amount, date, category, description

Tap an expense to edit or delete it

The data is stored locally using Hive (so persists across app restarts)

🛠️ Technology Stack

Flutter & Dart

Hive – Lightweight key-value/local database for Flutter 
FreeCodeCamp
+1

(Optional) Provider / Riverpod / Bloc – for state management depending on your implementation

(Optional) Shared Preferences – if storing simple app settings

✅ Why Hive?

Offline first – data is stored locally on device

Simple API, fast performance for lightweight datasets like expenses 
FreeCodeCamp

Works very well with Flutter for local persistence

📋 To Do / Future Improvements

Add summary charts (monthly, category-wise)

Add export/import (CSV) of expense data

Add backup/sync to cloud (Firebase, etc)

Add filters & search on expenses

Add user authentication (if moving online)

Improve UI/UX, animations

📐 Contributing

Feel free to fork this project, make your improvements and open a pull request.
Please adhere to the existing code style, add comments for new code, and update documentation where needed.

📄 License

Specify your license here (e.g., MIT, Apache 2.0) — or “All rights reserved”.
