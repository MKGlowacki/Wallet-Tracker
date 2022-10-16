import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../globals.dart';

class NewTransaction extends StatefulWidget {
  final Function addNewTransaction;

  NewTransaction(this.addNewTransaction);

  @override
  State<NewTransaction> createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  bool _addValue = false;
  DateTime _selectedDate;

  void _submitTransaction() {
    final enteredTitle = _titleController.text;
    final enteredAmount = double.parse(_amountController.text);

    if (enteredTitle.isEmpty || enteredAmount <= 0 || _selectedDate == null) {
      return;
    }

    widget.addNewTransaction(enteredTitle,
        _addValue ? enteredAmount : enteredAmount * -1, _selectedDate);
    
    

    Navigator.of(context).pop();
  }

  void _presentDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
    ).then((chosenDate) {
      if (chosenDate == null) {
        return;
      } else {
        setState(() {
          _selectedDate = chosenDate;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            TextField(
              decoration: InputDecoration(labelText: 'Title'),
              controller: _titleController,
              onSubmitted: (_) => _submitTransaction(),
            ),
            Row(
              children: [
                Flexible(
                  child: TextField(
                    decoration: InputDecoration(labelText: 'Amount'),
                    controller: _amountController,
                    keyboardType:
                        TextInputType.numberWithOptions(decimal: true),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      if (_addValue) {
                        _addValue = false;
                      } else {
                        _addValue = true;
                      }
                    });
                  },
                  style: _addValue
                      ? ElevatedButton.styleFrom(primary: Colors.green)
                      : ElevatedButton.styleFrom(primary: Colors.red),
                  child: _addValue
                      ? const Icon(Icons.add)
                      : const Icon(Icons.remove),
                )
              ],
            ),
            Container(
              height: 70,
              child: Row(
                children: [
                  Expanded(
                      child: Text(_selectedDate == null
                          ? 'No date chosen'
                          : 'Chosen date: ${DateFormat.yMMMd().format(_selectedDate)}')),
                  FlatButton(
                    onPressed: _presentDatePicker,
                    child: Text(
                      'Choose date',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    textColor: Theme.of(context).primaryColor,
                  )
                ],
              ),
            ),
            ElevatedButton(
                child: Text('Add transaction',
                    style: TextStyle(fontWeight: FontWeight.bold)),
                style: ElevatedButton.styleFrom(
                    primary: Theme.of(context).primaryColor),
                onPressed: _submitTransaction)
          ],
        ),
      ),
    );
  }
}
