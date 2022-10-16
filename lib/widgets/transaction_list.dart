import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import '../models/transaction.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final Function deleteTransaction;
  final oCcy = new NumberFormat("#,##0.00", "pl_PL");

  TransactionList(this.transactions, this.deleteTransaction);

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 400,
        child: transactions.isEmpty
            ? Column(
                children: [
                  Text(
                    'No transactions added yet!',
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  SizedBox(
                    height: 75,
                  ),
                  Container(
                      height: 200,
                      child: Image.asset(
                        './assets/images/waiting.png',
                        fit: BoxFit.cover,
                      )),
                ],
              )
            : ListView.builder(
                itemBuilder: (context, index) {
                  return Card(
                    margin: EdgeInsets.symmetric(vertical: 5, horizontal: 3),
                    child: ListTile(
                      leading: CircleAvatar( 
                        backgroundColor: transactions[index].amount > 0 ? Colors.green : Colors.red,
                        radius: 30,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: FittedBox(
                            child: Text(
                              '${oCcy.format(transactions[index].amount)}\nPLN',
                              textAlign: TextAlign.center,
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                      title: Text(
                        transactions[index].title,
                        style: Theme.of(context).textTheme.headline6,
                      ),
                      subtitle: Text(
                          DateFormat.yMMMd().format(transactions[index].date)),
                      trailing: IconButton(
                          icon: Icon(Icons.delete),
                          color: Theme.of(context).errorColor,
                          onPressed: () => deleteTransaction(transactions[index].id)),
                    ),
                  );
                },
                itemCount: transactions.length));
  }
}
