import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  final String label;
  final double spendingAmount;
  final double spendingPercentageOfTotal;

  ChartBar(this.label, this.spendingAmount, this.spendingPercentageOfTotal);

  @override
  Widget build(BuildContext context) {
    return Column(

      children: [
        Text(label),
        
        SizedBox(height: 4,),
        Container(
          height: 70,
          width: 10,
          child: Stack(children: [
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey, width: 1.0),
                color: Color.fromARGB(255, 212, 212, 212),
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            FractionallySizedBox(
              heightFactor: spendingPercentageOfTotal, 
              child: Container(decoration: spendingAmount < 0 
                ? BoxDecoration( color: Colors.red, borderRadius: BorderRadius.circular(10))
                : BoxDecoration( color: Colors.green, borderRadius: BorderRadius.circular(10))),),
          ]),
        ),
        SizedBox(height: 4,),
        Container(
          height: 35,
          child: FittedBox(
            child: Text('${spendingAmount.toStringAsFixed(0)}\nPLN', 
            textAlign: TextAlign.center,)))
        ],
    );
  }
}
