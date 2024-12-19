import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'loan.dart';
import 'loan_dashboard.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(
      LoanAdapter()); // Register the Hive adapter for the Loan model.
  await Hive.openBox<Loan>('loans'); // Open a Hive box to store loans.

  runApp(const ProviderScope(child: MyApp())); // Initialize Riverpod.
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Loan Application',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const LoanDashboard(), // Start with the dashboard.
    );
  }
}
