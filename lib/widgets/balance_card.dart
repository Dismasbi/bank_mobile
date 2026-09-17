import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class BalanceCard extends StatelessWidget {
  final double balance;
  final String accountNumber;

  const BalanceCard({
    super.key,
    required this.balance,
    required this.accountNumber,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: AppTheme.premiumGradient,
        borderRadius: BorderRadius.circular(28),
        boxShadow: [
          BoxShadow(
            color: AppTheme.premiumBlue.withOpacity(0.4),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'AVAILABLE BALANCE',
            style: TextStyle(
                color: Colors.white70, fontSize: 15, letterSpacing: 2),
          ),
          const SizedBox(height: 8),
          Text(
            '${balance.toStringAsFixed(0)} FBU',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 32,
              fontWeight: FontWeight.bold,
              letterSpacing: 1,
            ),
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              const Icon(Icons.credit_card, color: AppTheme.premiumGold),
              const SizedBox(width: 8),
              Text(
                '•••• $accountNumber',
                style: const TextStyle(color: Colors.white70, letterSpacing: 1),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
