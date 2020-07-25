import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import '../models/transaction.dart';

class TransactionItem extends StatelessWidget {
  const TransactionItem({
    Key key,
    @required this.transaction,
    @required this.deleteTran,
  }) : super(key: key);

  final Transaction transaction;
  final Function deleteTran;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: ListTile(
        leading: CircleAvatar(
          radius: 30,
          child: FittedBox(
            child: Text('\$${transaction.val}'),
          ),
        ),
        title: Text(
          '${transaction.title}',
          style: Theme.of(context).textTheme.headline6,
        ),
        subtitle: Text(
          '${DateFormat.yMMMd().format(transaction.date)}',
          style: Theme.of(context).textTheme.headline6,
        ),
        trailing: MediaQuery.of(context).size.width > 450
            ? FlatButton.icon(
          onPressed: () {
            deleteTran(transaction.id);
          },
          icon: Icon(Icons.delete),
          label: Text('Delete'),
          textColor: Theme.of(context).errorColor,
        )
            : IconButton(
          icon: Icon(Icons.delete),
          color: Theme.of(context).errorColor,
          onPressed: () {
            deleteTran(transaction.id);
          },
        ),
      ),
    );
  }
}
