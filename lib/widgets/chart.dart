import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import './chart_bar.dart';

import '../models/transaction.dart';

import '../globals.dart' as globals;

class Chart extends StatelessWidget {
  final oCcy = new NumberFormat("#,##0.00", "pl_PL");

  double maxShare = 0;

  List<Transaction> recentTransactions = globals.recentTransactions;

  List<Map<String, Object>> get groupedTransactionValues {
    double maxAmount = 0;

    List<Map<String, Object>> temp = List.from(List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(
        Duration(days: index),
      );
      double totalSum = 0;

      for (var i = 0; i < recentTransactions.length; i++) {
        if (recentTransactions[i].date.day == weekDay.day &&
            recentTransactions[i].date.month == weekDay.month &&
            recentTransactions[i].date.year == weekDay.year) {
          totalSum += recentTransactions[i].amount;
        }
      }
      return {
        'day': DateFormat.E().format(weekDay).substring(0, 2).toUpperCase(),
        'amount': totalSum,
      };
    }).reversed);
    double tempAmount;
    for (var i = 0; i < temp.length; i++) {
      tempAmount = temp[i]['amount'];

      if (tempAmount < 0) {
        tempAmount *= -1;
      }

      if (maxAmount < tempAmount) {
        maxAmount = tempAmount;
      }
    }

    return List.from(List.generate(7, (index) {
      return {
        'day': temp[index]['day'],
        'amount': temp[index]['amount'],
        'share': (maxAmount == 0)
            ? 0.0
            : ((temp[index]['amount'] as double < 0)
                ? ((temp[index]['amount'] as double) / maxAmount) * -1
                : (temp[index]['amount'] as double) / maxAmount)
      };
    }));
  }

  double get totalSpending {
    return groupedTransactionValues.fold(0.0, (sum, item) {
      return (sum + item['amount']);
    });
  }

  @override
  Widget build(BuildContext context) {
    globals.recentTransactionSum = totalSpending;


    // print(
    //     '${globals.recentTransactionSum} - weekly; ${globals.totalTransactionSum} - total; ${globals.monthlyTransactionSum} - monthly');

    // print(groupedTransactionValues);
    return Card(
      elevation: 6,
      margin: EdgeInsets.all(20),
      child: SingleChildScrollView(
        child: ConstrainedBox(
          constraints: BoxConstraints(minHeight: 150, maxHeight: 225),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Text(
                  'Weekly Balance',
                  style: Theme.of(context).textTheme.headline6,
                ),
              ),
              Text('${oCcy.format(totalSpending)} PLN',
                  style: TextStyle(
                      fontFamily: 'Quicksand',
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: totalSpending == 0
                          ? Colors.black
                          : (totalSpending > 0 ? Colors.green : Colors.red))),
              Flexible(
                child: Container(
                  padding: EdgeInsets.all(10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: groupedTransactionValues.map((data) {
                      return Flexible(
                          fit: FlexFit.tight,
                          child: ChartBar(data['day'], data['amount'],
                              data['share'] == null ? 0 : data['share']));
                    }).toList(),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
