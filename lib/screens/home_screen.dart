import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../data/bank_data.dart';
import '../theme/app_theme.dart';
import '../widgets/action_button.dart';
import '../widgets/balance_card.dart';
import '../widgets/transaction_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final bank = context.watch<BankData>();

    return SafeArea(
      child: LayoutBuilder(
        builder: (context, constraints) {
          final isTablet = constraints.maxWidth >= 600;

          return SingleChildScrollView(
            padding: EdgeInsets.all(isTablet ? 40 : 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const CircleAvatar(
                      radius: 25,
                      backgroundColor: AppTheme.premiumGold,
                      child: Icon(Icons.person, color: AppTheme.premiumBlue),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'WELCOME',
                            style: TextStyle(
                                color: Colors.grey, letterSpacing: 1.5),
                          ),
                          Text(
                            bank.account.owner,
                            style: const TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                                color: AppTheme.premiumBlue),
                          ),
                        ],
                      ),
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.notifications_none,
                          color: AppTheme.premiumGold),
                    ),
                  ],
                ),
                const SizedBox(height: 25),
                BalanceCard(
                    balance: bank.balance,
                    accountNumber: bank.account.accountNumber.toString()),
                const SizedBox(height: 30),
                const Text(
                  'OPERATIONS',
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: AppTheme.premiumBlue),
                ),
                const SizedBox(height: 15),
                GridView.count(
                  crossAxisCount: isTablet ? 4 : 3,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  crossAxisSpacing: 10,
                  children: [
                    ActionButton(
                      icon: Icons.add_circle_outline,
                      title: 'DEPOSIT',
                      onPressed: () =>
                          _showAmountDialog(context, 'DEPOSIT', bank.deposit),
                    ),
                    ActionButton(
                      icon: Icons.remove_circle_outline,
                      title: 'WITHDRAW',
                      onPressed: () =>
                          _showAmountDialog(context, 'WITHDRAW', bank.withdraw),
                    ),
                    ActionButton(
                      icon: Icons.send_outlined,
                      title: 'TRANSFER',
                      onPressed: () => context.push('/transfer'),
                    ),
                  ],
                ),
                const SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'RECENT TRANSACTIONS',
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: AppTheme.premiumBlue),
                    ),
                    TextButton(
                      onPressed: () => context.go('/transactions'),
                      child: const Text('VIEW ALL',
                          style: TextStyle(
                              color: AppTheme.premiumGold,
                              fontWeight: FontWeight.bold)),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                ...bank.transactions.take(4).map((tx) {
                  return TransactionCard(
                    transaction: tx,
                    onTap: () => context.push('/transaction/${tx.id}'),
                  );
                }),
              ],
            ),
          );
        },
      ),
    );
  }

  void _showAmountDialog(
      BuildContext context, String title, void Function(double) action) {
    final controller = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(title,
              style: const TextStyle(
                  color: AppTheme.premiumBlue, fontWeight: FontWeight.bold)),
          content: TextField(
            controller: controller,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              labelText: 'AMOUNT',
              prefixIcon: Icon(Icons.payments_outlined),
              border: OutlineInputBorder(),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('CANCEL', style: TextStyle(color: Colors.grey)),
            ),
            ElevatedButton(
              onPressed: () {
                final amount = double.tryParse(controller.text);
                Navigator.pop(context);
                if (amount == null || amount <= 0) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('INVALID AMOUNT')),
                  );
                  return;
                }
                try {
                  action(amount);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('$title COMPLETED SUCCESSFULLY')),
                  );
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(e.toString())),
                  );
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppTheme.premiumGold,
                foregroundColor: AppTheme.premiumBlue,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8)),
              ),
              child: const Text('CONFIRM'),
            ),
          ],
        );
      },
    );
  }
}
