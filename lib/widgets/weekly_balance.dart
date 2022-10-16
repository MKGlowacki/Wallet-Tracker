import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../globals.dart' as globals;

class WeeklyBalance extends StatelessWidget {
  final oCcy = new NumberFormat("#,##0.00", "pl_PL");

  double weeklyBalanceSum = 0;

  double get weeklyBalanceValue {
    if (globals.recentTransactionSum != null) {
      weeklyBalanceSum = globals.recentTransactionSum;
    }
    print("$weeklyBalanceSum - weekly");
    return weeklyBalanceSum;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      margin: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
      child: Container(
        height: 225,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: Text('Weekly Balance',
                  style: TextStyle(
                    fontFamily: 'Quicksand',
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  )),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 20, right: 20, left: 20),
              child: FittedBox(
                child: Text('${oCcy.format(weeklyBalanceValue)} PLN',
                    style: TextStyle(
                        fontFamily: 'Quicksand',
                        fontSize: 50,
                        fontWeight: FontWeight.bold,
                        color: weeklyBalanceValue == 0
                            ? Colors.black
                            : (weeklyBalanceValue > 0
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
