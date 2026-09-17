import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../data/bank_data.dart';
import '../theme/app_theme.dart';

class ProfileScreen extends StatelessWidget {
  final bool isDarkMode;
  final ValueChanged<bool> onThemeChanged;

  const ProfileScreen({
    super.key,
    required this.isDarkMode,
    required this.onThemeChanged,
  });

  @override
  Widget build(BuildContext context) {
    final bank = context.watch<BankData>();

    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.all(4),
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                  colors: [AppTheme.premiumGold, AppTheme.premiumBlue],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: const CircleAvatar(
                radius: 55,
                backgroundColor: Colors.white,
                child:
                    Icon(Icons.person, size: 60, color: AppTheme.premiumBlue),
              ),
            ),
            const SizedBox(height: 15),
            Text(
              bank.account.owner,
              style: const TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: AppTheme.premiumBlue,
                  letterSpacing: 2),
            ),
            const Text(
              'CLIENT BANK',
              style: TextStyle(color: Colors.grey, letterSpacing: 1),
            ),
            const SizedBox(height: 30),
            _ProfileItem(
              icon: Icons.account_balance_outlined,
              title: 'ACCOUNT NUMBER',
              value: bank.account.accountNumber.toString(),
            ),
            _ProfileItem(
              icon: Icons.person_outline,
              title: 'OWNER',
              value: bank.account.owner,
            ),
            _ProfileItem(
              icon: Icons.security_outlined,
              title: 'SECURITY',
              value: 'ACTIVATED',
            ),
            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16)),
              child: SwitchListTile(
                secondary: const Icon(Icons.dark_mode_outlined,
                    color: AppTheme.premiumGold),
                title: const Text('DARK MODE',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: AppTheme.premiumBlue)),
                subtitle: const Text('CHANGE APPEARANCE',
                    style: TextStyle(color: Colors.grey)),
                value: isDarkMode,
                onChanged: onThemeChanged,
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'BANK MOBILE • VERSION 1.0.0',
              style: TextStyle(color: Colors.grey, letterSpacing: 1),
            ),
          ],
        ),
      ),
    );
  }
}

class _ProfileItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final String value;

  const _ProfileItem({
    required this.icon,
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: ListTile(
        leading: Icon(icon, color: AppTheme.premiumGold),
        title: Text(title,
            style: const TextStyle(
                fontWeight: FontWeight.bold, color: AppTheme.premiumBlue)),
        trailing: Text(value, style: const TextStyle(color: Colors.grey)),
      ),
    );
  }
}
