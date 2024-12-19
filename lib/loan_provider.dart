import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import 'loan.dart';

final loanProvider = StateNotifierProvider<LoanNotifier, List<Loan>>((ref) {
  return LoanNotifier();
});

class LoanNotifier extends StateNotifier<List<Loan>> {
  final Box<Loan> _loanBox;

  LoanNotifier()
      : _loanBox = Hive.box<Loan>('loans'),
        super(Hive.box<Loan>('loans').values.toList());

  // Adds a new loan.
  void addLoan(double amount, int duration) {
    final loan = Loan(amount: amount, duration: duration);
    _loanBox.add(loan);
    state = [...state, loan];
  }

  void repayLoan(int index, double repaymentAmount) {
    final loan = state[index];
    loan.repay(repaymentAmount);
    _loanBox.putAt(index, loan);
    state = [...state];
  }

  // Gets completed loans.
  List<Loan> get completedLoans =>
      state.where((loan) => loan.status == 'Paid').toList();
}
