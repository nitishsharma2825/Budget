import 'dart:ui';
import 'dart:io';
import 'package:flutter/services.dart';

import './widgets/chart.dart';

import './widgets/New_Transaction.dart';
import 'package:flutter/material.dart';
import 'models/transaction.dart';
import './widgets/transaction_widget.dart';

void main() {
//  WidgetsFlutterBinding.ensureInitialized();
//  SystemChrome.setPreferredOrientations([
//    DeviceOrientation.portraitUp,
//    DeviceOrientation.portraitDown
//  ]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
      theme: ThemeData(
        primarySwatch: Colors.purple,
        accentColor: Colors.amber,
        fontFamily: 'Roboto',
        textTheme: ThemeData.light().textTheme.copyWith(
              headline6: TextStyle(
                fontFamily: 'SourceSansPro',
                fontSize: 18,
              ),
              button: TextStyle(
                color: Colors.white,
              ),
            ),
        appBarTheme: AppBarTheme(
          textTheme: ThemeData.light().textTheme.copyWith(
                headline6: TextStyle(
                  fontFamily: 'SourceSansPro',
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
        ),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with WidgetsBindingObserver {
  bool _showChart = false;

  final List<Transaction> transactions = [
//    Transaction(
//      id: "t1",
//      title: "Shoes",
//      val: 1299.50,
//      date: DateTime.now(),
//    ),
//    Transaction(
//      id: "t2",
//      title: "Watch",
//      val: 549.00,
//      date: DateTime.now(),
//    ),
  ];

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }
  @override
  void didChangeAppLifecycleState(AppLifecycleState state){
    print(state);
  }
  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  List<Transaction> get recentTransactions {
    return transactions.where((tran) {
      return tran.date.isAfter(DateTime.now().subtract(Duration(days: 7)));
    }).toList();
  }

  void addNewTransaction({var title, var amount, var chosenDate}) {
    var newTransaction = Transaction(
        title: title,
        val: amount,
        id: DateTime.now().toString(),
        date: chosenDate);
    setState(() {
      transactions.add(newTransaction);
    });
  }

  void addNewStartTransaction(BuildContext context) {
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (cont) {
          return NewTransaction(
            addTransaction: addNewTransaction,
          );
        });
  }

  void deleteTran(String id) {
    setState(() {
      transactions.removeWhere((tran) => tran.id == id);
    });
  }

  List<Widget> buildPortraitMode(AppBar appbar) {
    return [
      Container(
        height: (MediaQuery.of(context).size.height -
                appbar.preferredSize.height -
                MediaQuery.of(context).padding.top) *
            0.4,
        width: double.infinity,
        child: Chart(recentTransactions),
      ),
      Container(
        height: (MediaQuery.of(context).size.height -
                appbar.preferredSize.height -
                MediaQuery.of(context).padding.top) *
            0.6,
        child: TransactionList(
          transactions: transactions,
          deleteTran: deleteTran,
        ),
      ),
    ];
  }

  List<Widget> buildLandscapeMode(AppBar appbar) {
    return [
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            'Show Chart',
            style: Theme.of(context).textTheme.headline6,
          ),
          Switch(
              value: _showChart,
              onChanged: (val) {
                setState(() {
                  _showChart = val;
                });
              })
        ],
      ),
      _showChart == true
          ? Container(
              height: (MediaQuery.of(context).size.height -
                      appbar.preferredSize.height -
                      MediaQuery.of(context).padding.top) *
                  0.4,
              width: double.infinity,
              child: Chart(recentTransactions),
            )
          : Container(
              height: (MediaQuery.of(context).size.height -
                      appbar.preferredSize.height -
                      MediaQuery.of(context).padding.top) *
                  0.6,
              child: TransactionList(
                transactions: transactions,
                deleteTran: deleteTran,
              ),
            )
    ];
  }

  @override
  Widget build(BuildContext context) {
    bool isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;
    final appbar = AppBar(
      title: const Text("Personal Expenses"),
      actions: <Widget>[
        IconButton(
          icon: const Icon(Icons.add),
          onPressed: () {
            addNewStartTransaction(context);
          },
        )
      ],
    );
    return Scaffold(
      appBar: appbar,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              if (isLandscape == true) ...buildLandscapeMode(appbar), //builder methods
              if (isLandscape == false) ...buildPortraitMode(appbar),
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Platform.isIOS
          ? Container()
          : FloatingActionButton(
              child: Icon(
                Icons.add,
              ),
              onPressed: () {
                addNewStartTransaction(context);
              },
            ),
    );
  }
}
