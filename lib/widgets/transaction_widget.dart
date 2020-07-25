import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/transaction.dart';
import './transaction_item.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final Function deleteTran;

  TransactionList({this.transactions, this.deleteTran});

  @override
  Widget build(BuildContext context) {
    return transactions.isEmpty
        ? LayoutBuilder(builder: (context, constraints) {
            return Column(
              children: [
                Container(
                  height: constraints.maxHeight * 0.1,
                  child: FittedBox(
                    child: Text(
                      'No Transactions!',
                      style: Theme.of(context).textTheme.headline6,
                    ),
                  ),
                ),
                SizedBox(
                  height: constraints.maxHeight * 0.1,
                ),
                Container(
                  height: constraints.maxHeight * 0.8,
                  child: Image(
                    image: AssetImage('assets/images/waiting.png'),
                    fit: BoxFit.cover,
                  ),
                )
              ],
            );
          })
        : ListView(
            children: transactions.map((tran) {
              return TransactionItem(
                key: ValueKey(tran.id), //use with lists and statefulwidget
                transaction: tran,
                deleteTran: deleteTran,
              );
            }).toList(),
          );
  }
}
