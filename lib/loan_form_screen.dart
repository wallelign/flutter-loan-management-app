import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'loan_provider.dart';

class LoanFormScreen extends ConsumerWidget {
  const LoanFormScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final _amountController = TextEditingController();
    final _durationController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        iconTheme: const IconThemeData(
          color: Colors.white, // Change back arrow color to white
        ),
        title: const Center(
          // Align the text to the center
          child: Text(
            'New Loan',
            style: TextStyle(
              color: Colors.white, // Set the text color to white
              fontSize: 20.0, // Adjust font size if needed
              fontWeight: FontWeight.bold, // Make the text bold
            ),
            textAlign: TextAlign.center, // Ensure text is aligned center
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
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _amountController,
              decoration: const InputDecoration(
                labelText: 'Loan Amount',
                labelStyle: TextStyle(
                  color: Colors.grey, // Set label text color
                ),
              ),
              keyboardType: TextInputType.number,
              textAlign: TextAlign.center, // Align input text to the center
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _durationController,
              decoration: const InputDecoration(
                labelText: 'Duration (months)',
                labelStyle: TextStyle(
                  color: Colors.grey, // Set label text color
                ),
              ),
              keyboardType: TextInputType.number,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              child: Text('Submit'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
                textStyle: const TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontStyle: FontStyle.normal),
                shape: BeveledRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(2))),
              ),
              onPressed: () {
                final amount = double.parse(_amountController.text);
                final duration = int.parse(_durationController.text);
                ref.read(loanProvider.notifier).addLoan(amount, duration);
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
