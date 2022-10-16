library globals;

import 'models/transaction.dart';

List<Transaction> userTransactions = [];

double get totalTransactionSum {
  return userTransactions.fold(0.0, (sum, item) {
    return (sum + item.amount);
  });
}

double get monthlyTransactionSum {
  return monthlyTransactions.fold(0.0, (sum, item) {
    return (sum + item.amount);
  });
}


double recentTransactionSum;

List<Transaction> get recentTransactions {
  return userTransactions.where((transaction) {
    return transaction.date.isAfter(DateTime.now().subtract(Duration(days: 7)));
  }).toList();
}

List<Transaction> get monthlyTransactions {
  return userTransactions.where((transaction) {
    return transaction.date
        .isAfter(DateTime.now().subtract(Duration(days: 30)));
  }).toList();
}



