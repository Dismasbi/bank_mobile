import 'package:flutter_test/flutter_test.dart';
import 'package:bank_mobile/data/bank_data.dart';
//import 'package:bank_mobile/models/bank_transaction.dart';

void main() {
  test('Initial balance is correct', () {
    final bank = BankData.instance;
    expect(bank.balance, greaterThan(0));
  });

  test('Deposit increases balance', () {
    final bank = BankData.instance;
    final before = bank.balance;
    bank.deposit(1000);
    expect(bank.balance, before + 1000);
  });

  test('Withdraw decreases balance', () {
    final bank = BankData.instance;
    final before = bank.balance;
    bank.withdraw(500);
    expect(bank.balance, before - 500);
  });

  test('Withdraw with insufficient balance throws', () {
    final bank = BankData.instance;
    expect(() => bank.withdraw(bank.balance + 1), throwsException);
  });
}
