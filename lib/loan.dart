import 'package:hive/hive.dart';

part 'loan.g.dart'; // This is the file that will be auto-generated.

@HiveType(typeId: 0)
class Loan {
  @HiveField(0)
  final double amount; // Total loan amount.

  @HiveField(1)
  final int duration; // Loan duration in months.

  @HiveField(2)
  double remainingAmount; // Remaining loan amount to be repaid.

  @HiveField(3)
  String status; // Loan status: 'Active' or 'Paid'.

  Loan({required this.amount, required this.duration})
      : remainingAmount = amount,
        status = 'Active';

  // Method to repay part of the loan.
  void repay(double repaymentAmount) {
    remainingAmount -= repaymentAmount;
    if (remainingAmount <= 0) {
      remainingAmount = 0;
      status = 'Paid';
    }
  }
}
