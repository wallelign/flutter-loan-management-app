import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'loan_provider.dart';

class HistoryPage extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final completedLoans = ref.watch(loanProvider.select(
        (loans) => loans.where((loan) => loan.status == 'Paid').toList()));

    return Scaffold(
      appBar: AppBar(title: Text('Repayment History')),
      body: ListView.builder(
        itemCount: completedLoans.length,
        itemBuilder: (context, index) {
          final loan = completedLoans[index];

          return ListTile(
            title: Text('Loan: \$${loan.amount.toStringAsFixed(2)}'),
            subtitle: Text(
                'Duration: ${loan.duration} months\nStatus: ${loan.status}'),
          );
        },
      ),
    );
  }
}
