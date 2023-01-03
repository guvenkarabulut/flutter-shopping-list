import 'package:flutter/material.dart';
import 'package:flutter_transaction_app/transaction.dart';
import 'package:uuid/uuid.dart';
import 'package:flutter_transaction_app/main.dart';

class FormMainPage extends StatelessWidget {
  final List _transactions = [];

  void _navigateToForm(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => MyApp(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double amount = 0;
    String title = '';

    return Scaffold(
        appBar: AppBar(
          title: Text('Form'),
        ),
        body: Container(
          margin: EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Title',
                  hintText: 'Enter Title',
                ),
                validator: (value) => value.isEmpty ? 'Enter Title' : null,
                onChanged: (value) => value.isEmpty ? null : title = value,
              ),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Amount',
                  hintText: 'Enter Amount',
                ),
                validator: (value) => value.isEmpty ? 'Enter Amount' : null,
                onChanged: (value) =>
                    value.isEmpty ? null : amount = double.parse(value),
              ),
              OutlinedButton(
                  child: Text('Add Transaction'),
                  onPressed: () => {
                        Transaction(
                            id: Uuid().v4(),
                            title: title,
                            amount: amount,
                            date: DateTime.now()),
                        _navigateToForm(context)
                      },
                  style: OutlinedButton.styleFrom(
                    primary: Colors.blue,
                    backgroundColor: Colors.blue[100],
                    side: BorderSide(color: Colors.blue, width: 2),
                  ))
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.keyboard_return),
          onPressed: () {},
        ));
  }
}
