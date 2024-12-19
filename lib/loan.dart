import 'package:hive/hive.dart';

part 'loan.g.dart';

@HiveType(typeId: 0)
class Loan {
  @HiveField(0)
  final double amount;

  @HiveField(1)
  final int duration;

  @HiveField(2)
  double remainingAmount;
  @HiveField(3)
  String status;

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
