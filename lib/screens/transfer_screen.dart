import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../data/bank_data.dart';
import '../theme/app_theme.dart';

class TransferScreen extends StatefulWidget {
  const TransferScreen({super.key});

  @override
  State<TransferScreen> createState() => _TransferScreenState();
}

class _TransferScreenState extends State<TransferScreen> {
  final _formKey = GlobalKey<FormState>();
  final _recipientController = TextEditingController();
  final _amountController = TextEditingController();
  final _reasonController = TextEditingController();

  @override
  void dispose() {
    _recipientController.dispose();
    _amountController.dispose();
    _reasonController.dispose();
    super.dispose();
  }

  void _submitTransfer() {
    if (!_formKey.currentState!.validate()) return;

    final amount = double.parse(_amountController.text);
    final recipient = _recipientController.text.trim();

    try {
      context.read<BankData>().transfer(amount, recipient);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('TRANSFER COMPLETED SUCCESSFULLY')),
      );
      Navigator.pop(context);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.toString())),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('NEW TRANSFER')),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 650),
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'SEND MONEY',
                    style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: AppTheme.premiumBlue,
                        letterSpacing: 2),
                  ),
                  const SizedBox(height: 30),
                  TextFormField(
                    controller: _recipientController,
                    decoration: InputDecoration(
                      labelText: 'RECIPIENT',
                      prefixIcon: const Icon(Icons.person_outline),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16)),
                      focusedBorder: const OutlineInputBorder(
                        borderSide:
                            BorderSide(color: AppTheme.premiumGold, width: 2),
                        borderRadius: BorderRadius.all(Radius.circular(16)),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'RECIPIENT IS REQUIRED';
                      }
                      if (value.trim().length < 3) {
                        return 'RECIPIENT MUST HAVE AT LEAST 3 CHARACTERS';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 18),
                  TextFormField(
                    controller: _amountController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: 'AMOUNT',
                      suffixText: 'FBU',
                      prefixIcon: const Icon(Icons.payments_outlined),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16)),
                      focusedBorder: const OutlineInputBorder(
                        borderSide:
                            BorderSide(color: AppTheme.premiumGold, width: 2),
                        borderRadius: BorderRadius.all(Radius.circular(16)),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'AMOUNT IS REQUIRED';
                      }
                      final amount = double.tryParse(value);
                      if (amount == null || amount <= 0) {
                        return 'ENTER A VALID AMOUNT';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 18),
                  TextFormField(
                    controller: _reasonController,
                    maxLines: 3,
                    decoration: InputDecoration(
                      labelText: 'REASON',
                      prefixIcon: const Icon(Icons.description_outlined),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16)),
                      focusedBorder: const OutlineInputBorder(
                        borderSide:
                            BorderSide(color: AppTheme.premiumGold, width: 2),
                        borderRadius: BorderRadius.all(Radius.circular(16)),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'REASON IS REQUIRED';
                      }
                      if (value.trim().length < 3) {
                        return 'REASON MUST HAVE AT LEAST 3 CHARACTERS';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 30),
                  SizedBox(
                    width: double.infinity,
                    height: 56,
                    child: ElevatedButton.icon(
                      onPressed: _submitTransfer,
                      icon: const Icon(Icons.send),
                      label: const Text('CONFIRM TRANSFER'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppTheme.premiumGold,
                        foregroundColor: AppTheme.premiumBlue,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16)),
                        textStyle: const TextStyle(
                            fontWeight: FontWeight.bold, letterSpacing: 2),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
