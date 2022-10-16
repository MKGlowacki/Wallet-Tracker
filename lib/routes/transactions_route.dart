import 'package:flutter/material.dart';
import 'package:myexpenses/widgets/chart.dart';

import '../models/transaction.dart';
import '../widgets/new_transaction.dart';
import '../widgets/transaction_list.dart';

import '../globals.dart' as globals;

class TransactionsRoute extends StatefulWidget {
  @override
  State<TransactionsRoute> createState() => _TransactionsRouteState();
}

class _TransactionsRouteState extends State<TransactionsRoute> {
  void _addNewTransaction(String title, double amount, DateTime date) {
    final newTransaction = Transaction(
        id: DateTime.now().toString(),
        title: title,
        amount: amount,
        date: date);

    setState(() {
      globals.userTransactions.add(newTransaction);

      globals.userTransactions
          .sort((a, b) => b.date.toUtc().compareTo(a.date.toUtc()));
    });
  }

  void _startAddNewTransaction(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (_) {
          return GestureDetector(
            child: NewTransaction(_addNewTransaction),
            onTap: () {},
            behavior: HitTestBehavior.opaque,
          );
        });
  }

  void _deleteTransaction(String id) {
    setState(() {
      globals.userTransactions.removeWhere((element) {
        return element.id == id;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: GestureDetector(
          onVerticalDragUpdate: (details) {
            int sensitivity = 8;
            if (details.delta.dy > sensitivity) {
              Navigator.pop(context);
            }
          },
          child: Column(
            //mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Chart(),
              TransactionList(globals.userTransactions, _deleteTransaction)
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => _startAddNewTransaction(context),
      ),

     
    );
  }
}
