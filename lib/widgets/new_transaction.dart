import 'package:flutter/material.dart';

class NewTransaction extends StatelessWidget {
  final Function _addTx;
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();

  NewTransaction(this._addTx);

  void _onSubmit() {
    final enteredTitle = _titleController.text;

    if (enteredTitle.isEmpty || _amountController.text.isEmpty) {
      return;
    }

    final enteredAmount = double.parse(_amountController.text);

    if (enteredAmount <= 0) {
      return;
    }

    _addTx(enteredTitle, enteredAmount);
  }

  void _onSubmitS(String _) => _onSubmit();

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
            ),
            TextField(
              decoration: InputDecoration(labelText: 'Amount'),
              controller: _amountController,
              keyboardType: TextInputType.number,
              onSubmitted: _onSubmitS,
            ),
            FlatButton(
              child: Text('Add Transaction'),
              textColor: Colors.purple,
              onPressed: _onSubmit,
            )
          ],
        ),
      ),
    );
  }
}
