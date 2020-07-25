import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  final String label;
  final double amount;
  final double pctoftotspend;

  ChartBar({this.amount, this.label, this.pctoftotspend});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context,constraints){
      return Column(
        children: <Widget>[
          Container(
              height: constraints.maxHeight*0.15,
              child: FittedBox(child: Text('\$' + amount.toStringAsFixed(0)))),
          SizedBox(
            height: constraints.maxHeight*0.05,
          ),
          Container(
            height: constraints.maxHeight*0.6,
            width: 10,
            child: Stack(
              children: <Widget>[
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey, width: 1.0),
                    borderRadius: BorderRadius.circular(10),
                    color: Color.fromRGBO(220, 220, 220, 1),
                  ),
                ),
                FractionallySizedBox(
                  heightFactor: pctoftotspend,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: constraints.maxHeight*0.05,
          ),
          Container(
            height: constraints.maxHeight*0.15,
              child: FittedBox(child: Text(label))),
        ],
      );
    });
  }
}
