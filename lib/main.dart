import 'package:flutter/material.dart';
import 'package:myexpenses/routes/transactions_route.dart';
import 'package:myexpenses/widgets/monthly_balance.dart';
import 'package:myexpenses/widgets/total_balance.dart';
import './widgets/weekly_balance.dart';

import 'widgets/new_transaction.dart';
import 'widgets/chart.dart';

import 'models/transaction.dart';

import './globals.dart' as globals;

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Wallet Tracker',
      theme: ThemeData(
          primarySwatch: Colors.indigo,
          fontFamily: 'Quicksand',
          textTheme: ThemeData.light().textTheme.copyWith(
              headline6: const TextStyle(
                  fontFamily: 'Quicksand',
                  fontSize: 18,
                  fontWeight: FontWeight.bold)),
          appBarTheme: const AppBarTheme(
              titleTextStyle: TextStyle(
                  fontFamily: 'OpenSans',
                  fontSize: 20,
                  fontWeight: FontWeight.bold))),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Route _createRoute() {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) =>
          TransactionsRoute(),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(0.0, 1.0);
        const end = Offset.zero;
        const curve = Curves.ease;
        final tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

        //final offsetAnimation = animation.drive(tween);
        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
    );
  }

  Future<void> _collectData(BuildContext context) async {
    // Navigator.push returns a Future that completes after calling
    // Navigator.pop on the Selection Screen.
    final result = await Navigator.of(context).push(_createRoute());

    if (!mounted) return;
    setState(() {
      globals.monthlyTransactionSum;
      globals.totalTransactionSum;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Wallet Tracker'),
      ),
      body: SingleChildScrollView(
        child: GestureDetector(
          onVerticalDragUpdate: (details) {
            int sensitivity = 8;
            if (details.delta.dy < -sensitivity) {
              _collectData(context);
            }
          },
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                GestureDetector(
                  child: WeeklyBalance(),
                  onTap: () {
                    _collectData(context);
                  },
                ),
                MonthlyBalance(),
                TotalBalance()
              ]),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.attach_money),
        onPressed: () {
          // _collectData(context);
          _collectData(context);
        },
      ),
    );
  }
}
