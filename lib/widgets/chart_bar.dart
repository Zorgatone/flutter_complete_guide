import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  final String _label;
  final double _spendingAmount;
  final double _spendingPctOfTotal;

  ChartBar(this._label, this._spendingAmount, this._spendingPctOfTotal);

  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      FittedBox(child: Text('\$${_spendingAmount.toStringAsFixed(0)}')),
      SizedBox(height: 4),
      Container(
        height: 60,
        width: 10,
        child: Stack(
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.green, width: 1.0),
                color: Color.fromRGBO(220, 220, 220, 1),
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            FractionallySizedBox(
              heightFactor: _spendingPctOfTotal,
              child: Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            )
          ],
        ),
      ),
      SizedBox(height: 4),
      Text(_label),
    ]);
  }
}
