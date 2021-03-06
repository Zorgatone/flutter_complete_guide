import 'package:flutter/material.dart';
import 'package:flutter_complete_guide/widgets/transaction_list.dart';

import './models/transaction.dart';
import './widgets/chart.dart';
import './widgets/new_transaction.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  static const String appName = 'Personal Expenses';
  static const MaterialColor primaryColor = Colors.purple;
  static const MaterialColor accentColor = Colors.amber;
  static const String mainFont = 'Quicksand';
  static const String altFont = 'OpenSans';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: appName,
      theme: ThemeData(
        primarySwatch: primaryColor,
        accentColor: accentColor,
        fontFamily: mainFont,
        textTheme: ThemeData.light().textTheme.copyWith(
              headline6: TextStyle(
                fontFamily: 'OpenSans',
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
        appBarTheme: AppBarTheme(
          textTheme: ThemeData.light().textTheme.copyWith(
                headline6: TextStyle(
                  fontFamily: altFont,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
        ),
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transaction> _userTransactions = [
    // Transaction(
    //   id: 't1',
    //   title: 'New Shoes',
    //   amount: 69.99,
    //   date: DateTime.now(),
    // ),
    // Transaction(
    //   id: 't2',
    //   title: 'Weekly Groceries',
    //   amount: 16.53,
    //   date: DateTime.now(),
    // ),
  ];

  void _addNewTransaction(String txTitle, double txAmount) {
    setState(() {
      final newTx = Transaction(
        title: txTitle,
        amount: txAmount,
        date: DateTime.now(),
        id: DateTime.now().toString(),
      );

      _userTransactions.add(newTx);
    });
  }

  List<Transaction> get _recentTransactions {
    final now = DateTime.now();
    final startDate =
        new DateTime(now.year, now.month, now.day).subtract(Duration(days: 7));

    return _userTransactions.where((tx) => tx.date.isAfter(startDate)).toList();
  }

  void _startAddNewTransaction(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (_) => NewTransaction(_addNewTransaction),
    );
  }

  @override
  Widget build(BuildContext context) {
    final _addTxCallback = () => _startAddNewTransaction(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(MyApp.appName),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            onPressed: _addTxCallback,
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Container(
              width: double.infinity,
              child: Chart(_recentTransactions),
            ),
            TransactionList(_userTransactions),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: _addTxCallback,
      ),
    );
  }
}
