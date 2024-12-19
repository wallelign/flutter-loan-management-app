import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'loan_provider.dart';
import 'loan_form_screen.dart';

class LoanDashboard extends ConsumerWidget {
  const LoanDashboard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loans = ref.watch(loanProvider);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Center(
          // Align the text to the center
          child: Text(
            'Loan Dashboard',
            style: TextStyle(
              color: Colors.white, // Set the text color to white
              fontSize: 20.0, // Adjust font size if needed
              fontWeight: FontWeight.bold, // Make the text bold
            ),
            textAlign:
                TextAlign.center, // Ensure text is aligned center if needed
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.history),
            onPressed: () {
              // Navigate to history screen (not yet implemented).
            },
          ),
        ],
      ),
      body: loans.isEmpty
          ? const Center(child: Text('No loans available.'))
          : ListView.builder(
              itemCount: loans.length,
              itemBuilder: (context, index) {
                final loan = loans[index];
                final _repaymentController = TextEditingController();

                return ListTile(
                  title: Text('Loan: \ETB ${loan.amount.toStringAsFixed(2)}'),
                  subtitle: Text(
                    'Remaining: \ETB ${loan.remainingAmount.toStringAsFixed(2)}\nStatus: ${loan.status}',
                  ),
                  trailing: loan.status == 'Active'
                      ? Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            SizedBox(
                              width: 100,
                              child: TextField(
                                controller: _repaymentController,
                                decoration:
                                    const InputDecoration(labelText: 'Repay'),
                                keyboardType: TextInputType.number,
                              ),
                            ),
                            IconButton(
                              icon: const Icon(Icons.check),
                              onPressed: () {
                                final amount =
                                    double.parse(_repaymentController.text);
                                ref
                                    .read(loanProvider.notifier)
                                    .repayLoan(index, amount);
                              },
                            ),
                          ],
                        )
                      : null,
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          // Check if there are active loans
          final hasUnpaidLoan = loans.any((loan) => loan.status == 'Active');

          if (hasUnpaidLoan) {
            // Show a message if a loan is not fully repaid
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('First pay the previous loan!'),
              ),
            );
          } else {
            // Navigate to the loan form if all loans are repaid
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const LoanFormScreen()),
            );
          }
        },
      ),
    );
  }
}
