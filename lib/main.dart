import 'package:flutter/material.dart';
import 'package:flutter_shopping_list/transaction.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';
import 'package:fl_chart/fl_chart.dart';
import 'dart:math' as math;

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter App',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transaction> _transactions = [];
  Function addTransactions() {
    setState(() {
      _transactions.add(Transaction(
          id: Uuid().v4(),
          title: titleInput,
          amount: double.parse(amountInput),
          date: DateTime.now()));
    });
  }

  String titleInput;

  String amountInput;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Flutter App'),
        ),
        body: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Container(
                width: 200,
                height: 200,
                child: Card(
                  child: PieChart(
                    PieChartData(
                      borderData: FlBorderData(show: false),
                      sectionsSpace: 0,
                      centerSpaceRadius: 40,
                      sections: _transactions
                          .map((e) => PieChartSectionData(
                                color: Color(
                                        (math.Random().nextDouble() * 0xFFFFFF)
                                            .toInt())
                                    .withOpacity(1.0),
                                value: e.amount,
                                title: e.title,
                                radius: 50,
                                titleStyle: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              ))
                          .toList(),
                    ),
                  ),
                  elevation: 5,
                ),
              ),
              Card(
                elevation: 5,
                margin: EdgeInsets.all(25),
                child: Container(
                  padding: EdgeInsets.all(10),
                  child: Column(
                    children: <Widget>[
                      TextField(
                        decoration: InputDecoration(labelText: 'Title'),
                        onChanged: ((value) => titleInput = value),
                      ),
                      TextField(
                        decoration: InputDecoration(labelText: 'Amount'),
                        onChanged: ((value) => amountInput = value),
                      ),
                      ElevatedButton(
                        child: Text('Add Transaction'),
                        onPressed: () {
                          addTransactions();
                        },
                      ),
                    ],
                  ),
                ),
              ),
              Column(
                children: _transactions.map((tx) {
                  return Card(
                    child: Row(
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.symmetric(
                            vertical: 10,
                            horizontal: 15,
                          ),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.grey[200],
                              width: 1,
                            ),
                          ),
                          padding: EdgeInsets.all(10),
                          child: Text(
                            '\$${tx.amount}',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              color: Colors.blue,
                            ),
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              tx.title,
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(DateFormat.yMMMd().format(tx.date),
                                style: TextStyle(
                                  color: Colors.grey,
                                )),
                          ],
                        )
                      ],
                    ),
                  );
                }).toList(),
              ),
            ]),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
        ));
  }
}
