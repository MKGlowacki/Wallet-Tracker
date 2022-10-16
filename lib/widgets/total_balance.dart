import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../globals.dart' as globals;

class TotalBalance extends StatelessWidget {
  double totalBalance = 0;
  final oCcy = new NumberFormat("#,##0.00", "pl_PL");

  double get totalBalanceValue {
    if (globals.totalTransactionSum != null) {
      totalBalance = globals.totalTransactionSum;
    }

    print("$totalBalance - total");
    return totalBalance;
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
              child: Text('Total Balance',
                  style: TextStyle(
                    fontFamily: 'Quicksand',
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  )),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 20, right: 20, left: 20),
              child: FittedBox(
                child: Text('${oCcy.format(totalBalanceValue)} PLN',
                    style: TextStyle(
                        fontFamily: 'Quicksand',
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: totalBalanceValue == 0
                            ? Colors.black
                            : (totalBalanceValue > 0
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
