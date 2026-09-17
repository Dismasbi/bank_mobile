import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../data/bank_data.dart';
import '../models/bank_transaction.dart';
import '../theme/app_theme.dart';
import '../widgets/transaction_card.dart';

class TransactionsScreen extends StatefulWidget {
  const TransactionsScreen({super.key});

  @override
  State<TransactionsScreen> createState() => _TransactionsScreenState();
}

class _TransactionsScreenState extends State<TransactionsScreen> {
  String _search = '';
  String _filter = 'ALL';

  @override
  Widget build(BuildContext context) {
    final bank = context.watch<BankData>();
    final filtered = _filterTransactions(bank.transactions);

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'TRANSACTIONS',
              style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: AppTheme.premiumBlue,
                  letterSpacing: 2),
            ),
            const SizedBox(height: 8),
            const Text(
              'VIEW YOUR OPERATION HISTORY',
              style: TextStyle(color: Colors.grey, letterSpacing: 1),
            ),
            const SizedBox(height: 20),
            TextField(
              onChanged: (value) => setState(() => _search = value),
              decoration: InputDecoration(
                hintText: 'SEARCH TRANSACTIONS',
                prefixIcon: const Icon(Icons.search),
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
                focusedBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: AppTheme.premiumGold, width: 2),
                  borderRadius: BorderRadius.all(Radius.circular(16)),
                ),
              ),
            ),
            const SizedBox(height: 15),
            DropdownButtonFormField<String>(
              initialValue: _filter,
              decoration: InputDecoration(
                labelText: 'FILTER',
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
                focusedBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: AppTheme.premiumGold, width: 2),
                  borderRadius: BorderRadius.all(Radius.circular(16)),
                ),
              ),
              items: const [
                DropdownMenuItem(value: 'ALL', child: Text('ALL')),
                DropdownMenuItem(value: 'INCOME', child: Text('INCOME')),
                DropdownMenuItem(value: 'EXPENSE', child: Text('EXPENSE')),
              ],
              onChanged: (value) => setState(() => _filter = value!),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: filtered.isEmpty
                  ? const Center(
                      child: Text('NO TRANSACTIONS FOUND',
                          style: TextStyle(color: Colors.grey)))
                  : ListView.builder(
                      itemCount: filtered.length,
                      itemBuilder: (context, index) {
                        final tx = filtered[index];
                        return TransactionCard(
                          transaction: tx,
                          onTap: () => context.push('/transaction/${tx.id}'),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }

  List<BankTransaction> _filterTransactions(List<BankTransaction> all) {
    return all.where((tx) {
      final matchesSearch =
          tx.title.toLowerCase().contains(_search.toLowerCase()) ||
              tx.description.toLowerCase().contains(_search.toLowerCase());
      bool matchesFilter = true;
      if (_filter == 'INCOME') matchesFilter = tx.isIncome;
      if (_filter == 'EXPENSE') matchesFilter = !tx.isIncome;
      return matchesSearch && matchesFilter;
    }).toList();
  }
}
