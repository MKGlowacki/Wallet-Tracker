import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../globals.dart' as globals;

class MonthlyBalance extends StatelessWidget {
  final oCcy = new NumberFormat("#,##0.00", "pl_PL");

  double monthlyBalanceSum = 0;

  double get monthlyBalanceValue {
    if (globals.monthlyTransactionSum != null) {
      monthlyBalanceSum = globals.monthlyTransactionSum;
    }
    print("$monthlyBalanceSum - monthly");
    return monthlyBalanceSum;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      child: Container(
        height: 150,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: Text('Monthly Balance',
                  style: TextStyle(
                    fontFamily: 'Quicksand',
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  )),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 20, right: 20, left: 20),
              child: FittedBox(
                child: Text('${oCcy.format(monthlyBalanceValue)} PLN',
                    style: TextStyle(
                        fontFamily: 'Quicksand',
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: monthlyBalanceValue == 0
                            ? Colors.black
                            : (monthlyBalanceValue > 0
                                ? Colors.green
                                : Colors.red))),
              ),
            )
          ],
        ),
      ),
    );
  }
}
