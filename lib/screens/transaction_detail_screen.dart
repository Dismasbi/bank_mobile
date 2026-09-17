import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../data/bank_data.dart';
import '../theme/app_theme.dart';

class TransactionDetailScreen extends StatelessWidget {
  final String transactionId;

  const TransactionDetailScreen({super.key, required this.transactionId});

  @override
  Widget build(BuildContext context) {
    final bank = context.watch<BankData>();
    final tx = bank.findById(transactionId);

    if (tx == null) {
      return Scaffold(
        appBar: AppBar(title: const Text('TRANSACTION NOT FOUND')),
        body: const Center(
            child: Text('TRANSACTION NOT FOUND',
                style: TextStyle(color: Colors.grey))),
      );
    }

    final isIncome = tx.isIncome;

    return Scaffold(
      appBar: AppBar(title: const Text('TRANSACTION DETAILS')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  height: 150,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    gradient: AppTheme.premiumGradient,
                    borderRadius: BorderRadius.circular(25),
                    boxShadow: [
                      BoxShadow(
                          color: AppTheme.premiumBlue.withOpacity(0.4),
                          blurRadius: 20,
                          offset: const Offset(0, 10)),
                    ],
                  ),
                ),
                Column(
                  children: [
                    Icon(
                      isIncome ? Icons.arrow_downward : Icons.arrow_upward,
                      color: AppTheme.premiumGold,
                      size: 45,
                    ),
                    const SizedBox(height: 10),
                    Text(
                      '${isIncome ? '+' : '-'}${tx.amount.toStringAsFixed(0)} FBU',
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 25),
            Card(
              elevation: 8,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16)),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    _InfoRow(title: 'TITLE', value: tx.title),
                    _InfoRow(title: 'DESCRIPTION', value: tx.description),
                    _InfoRow(title: 'ID', value: tx.id),
                    _InfoRow(
                        title: 'DATE',
                        value: DateFormat('dd/MM/yyyy HH:mm').format(tx.date)),
                    _InfoRow(
                        title: 'TYPE', value: isIncome ? 'INCOME' : 'EXPENSE'),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  final String title;
  final String value;

  const _InfoRow({required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        children: [
          Expanded(
              child: Text(title,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: AppTheme.premiumBlue))),
          Flexible(
              child: Text(value,
                  textAlign: TextAlign.end,
                  style: const TextStyle(color: Colors.grey))),
        ],
      ),
    );
  }
}
