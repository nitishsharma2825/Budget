import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  final Function addTransaction;

  NewTransaction({this.addTransaction});

  @override
  _NewTransactionState createState() {
    print("Constructor widget");
    return _NewTransactionState();
  }
}

class _NewTransactionState extends State<NewTransaction> {
  final amountController = TextEditingController();
  DateTime _selectedDate;
  final titleController = TextEditingController();

  @override
  void initState() {
    print("initstate");
    super.initState();
  }

  @override
  void didUpdateWidget(NewTransaction oldWidget) {
    print("Didupdate");
    super.didUpdateWidget(oldWidget);
  }
  @override
  void dispose() {
    print("dispose");
    super.dispose();
  }
  void submit() {
    final text = titleController.text;
    final amount = double.parse(amountController.text);
    if (text.isEmpty || amount < 0 || _selectedDate==null) {
      return;
    }
    widget.addTransaction(title: text, amount: amount, chosenDate:_selectedDate);
    Navigator.of(context).pop();
  }

  void presentDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime.now(),
    ).then((pickedDate) {
      if (pickedDate == null) {
        return;
      }
      setState(() {
        _selectedDate = pickedDate;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.only(top:10,left: 10,right: 10,bottom: MediaQuery.of(context).viewInsets.bottom),
        child: Card(
          child: Container(
            padding: EdgeInsets.all(10),
            child: Column(
              children: <Widget>[
                TextField(
                  decoration: InputDecoration(labelText: "Title"),
                  controller: titleController,
                  onSubmitted: (_) {
                    submit();
                  },
                ),
                TextField(
                  decoration: InputDecoration(labelText: "Amount"),
                  controller: amountController,
                  keyboardType: TextInputType.number,
                  onSubmitted: (_) {
                    submit();
                  },
                ),
                Container(
                  height: 70,
                  child: Row(
                    children: <Widget>[
                      Expanded(
                          child: Text(
                        _selectedDate == null
                            ? 'No Date chosen!'
                            : 'Picked Date:${DateFormat.yMd().format(_selectedDate)}',
                        style: Theme.of(context).textTheme.headline6,
                      )),
                      FlatButton(
                        textColor: Theme.of(context).primaryColor,
                        child: Text(
                          'Choose Date',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        onPressed: presentDatePicker,
                      ),
                    ],
                  ),
                ),
                RaisedButton(
                  onPressed: submit,
                  color: Theme.of(context).primaryColor,
                  textColor: Theme.of(context).textTheme.button.color,
                  child: Text("Add Transaction"),
                )
              ],
              crossAxisAlignment: CrossAxisAlignment.end,
            ),
          ),
        ),
      ),
    );
  }
}
