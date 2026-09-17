import 'package:flutter/foundation.dart';
import '../models/account.dart';
import '../models/bank_transaction.dart';

class BankData extends ChangeNotifier {
  static final BankData instance = BankData._internal();

  BankData._internal();

  final Account account = Account(accountNumber: 100001, owner: 'DISMAS');

  final List<BankTransaction> _transactions = [
    BankTransaction(
      id: 'TX001',
      title: 'SALARY',
      description: 'MONTHLY SALARY',
      amount: 850000,
      type: TransactionType.income,
      date: DateTime(2026, 8, 30),
    ),
    BankTransaction(
      id: 'TX002',
      title: 'DEPOSIT',
      description: 'CASH DEPOSIT',
      amount: 250000,
      type: TransactionType.income,
      date: DateTime(2026, 8, 28),
    ),
    BankTransaction(
      id: 'TX003',
      title: 'ELECTRICITY BILL',
      description: 'PAYMENT FOR ELECTRICITY',
      amount: 75000,
      type: TransactionType.expense,
      date: DateTime(2026, 8, 26),
    ),
    BankTransaction(
      id: 'TX004',
      title: 'TRANSFER TO JEAN',
      description: 'TRANSFER TO JEAN',
      amount: 120000,
      type: TransactionType.expense,
      date: DateTime(2026, 8, 24),
    ),
    BankTransaction(
      id: 'TX005',
      title: 'SHOPPING',
      description: 'PURCHASE AT STORE',
      amount: 95000,
      type: TransactionType.expense,
      date: DateTime(2026, 8, 20),
    ),
    BankTransaction(
      id: 'TX006',
      title: 'DEPOSIT',
      description: 'ATM DEPOSIT',
      amount: 300000,
      type: TransactionType.income,
      date: DateTime(2026, 8, 18),
    ),
  ];

  List<BankTransaction> get transactions => List.unmodifiable(_transactions);

  double get balance {
    double total = 0;
    for (final tx in _transactions) {
      total += tx.isIncome ? tx.amount : -tx.amount;
    }
    return total;
  }

  BankTransaction? findById(String id) {
    try {
      return _transactions.firstWhere((tx) => tx.id == id);
    } catch (_) {
      return null;
    }
  }

  void addTransaction(BankTransaction tx) {
    _transactions.insert(0, tx);
    notifyListeners();
  }

  void deposit(double amount) {
    addTransaction(BankTransaction(
      id: 'TX${_transactions.length + 100}',
      title: 'DEPOSIT',
      description: 'CASH DEPOSIT',
      amount: amount,
      type: TransactionType.income,
      date: DateTime.now(),
    ));
  }

  void withdraw(double amount) {
    if (amount > balance) {
      throw Exception('INSUFFICIENT BALANCE');
    }
    addTransaction(BankTransaction(
      id: 'TX${_transactions.length + 100}',
      title: 'WITHDRAWAL',
      description: 'ATM WITHDRAWAL',
      amount: amount,
      type: TransactionType.expense,
      date: DateTime.now(),
    ));
  }

  void transfer(double amount, String recipient) {
    if (amount > balance) {
      throw Exception('INSUFFICIENT BALANCE');
    }
    addTransaction(BankTransaction(
      id: 'TX${_transactions.length + 100}',
      title: 'TRANSFER TO $recipient',
      description: 'TRANSFER TO $recipient',
      amount: amount,
      type: TransactionType.expense,
      date: DateTime.now(),
    ));
  }
}
