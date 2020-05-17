import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import './chart_bar.dart';
import '../models/transaction.dart';

class Chart extends StatelessWidget {
  final List<Transaction> _recentTransactions;

  Chart(this._recentTransactions);

  List<Map<String, Object>> get _groupedTransactionValues =>
      List.generate(7, (index) {
        final weekDay = DateTime.now().subtract(Duration(days: index));
        var totalSum = 0.0;

        for (var i = 0, len = _recentTransactions.length; i < len; ++i) {
          final tx = _recentTransactions[i];
          final txDate = tx.date;

          if (txDate.day == weekDay.day &&
              txDate.month == weekDay.month &&
              txDate.year == weekDay.year) {
            totalSum += tx.amount;
          }
        }

        print(totalSum);

        return {
          'day': DateFormat.E().format(weekDay).substring(0, 1),
          'amount': totalSum
        };
      });

  double get _totalSpending {
    return _groupedTransactionValues.fold(0.0, (sum, item) {
      return sum + item['amount'];
    });
  }

  @override
  Widget build(BuildContext context) {
    print(_groupedTransactionValues);
    final total = _totalSpending;
    return Card(
      elevation: 6,
      margin: EdgeInsets.all(20),
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: _groupedTransactionValues.map((data) {
            return Flexible(
              fit: FlexFit.tight,
              child: ChartBar(
                data['day'],
                data['amount'],
                total == 0.0 ? 0.0 : (data['amount'] as double) / total,
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
