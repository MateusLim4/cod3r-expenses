import 'dart:io';
import 'dart:math';
import 'package:flutter/cupertino.dart';
import '../assets/fonts/fonts.dart';
import 'package:flutter/material.dart';
import 'components/chart/chart.dart';
import 'components/form/transaction_form.dart';
import 'components/cardList/transaction_list.dart';
import 'models/transaction.dart';

void main() => runApp(const ExpensesApp());

class ExpensesApp extends StatelessWidget {
  const ExpensesApp({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeData tema = ThemeData();
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: tema.copyWith(
        colorScheme: tema.colorScheme.copyWith(
          primary: Colors.purple[700],
          secondary: Colors.amber[700],
        ),
        textTheme: tema.textTheme.copyWith(
          headline6: TextStyle(fontFamily: Fonts().quicksandBold.fontFamily),
        ),
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<Transaction> _transactions = [];
  bool _showChart = false;

  List<Transaction> get _recentTransactions {
    return _transactions.where((tr) {
      return tr.date.isAfter(
        DateTime.now().subtract(
          const Duration(days: 7),
        ),
      );
    }).toList();
  }

  _addTransaction(String title, double value, DateTime date) {
    final newTransaction = Transaction(
        id: Random().nextDouble().toString(),
        title: title,
        value: value,
        date: date);

    setState(() {
      _transactions.add(newTransaction);
    });

    //Hide modal after form submission.
    Navigator.of(context).pop();
  }

  void _openTransactionFormModal(BuildContext context) async {
    showModalBottomSheet(
        context: context,
        builder: ((_) {
          return TransactionForm(
            onSubmit: _addTransaction,
          );
        }));
  }

  _deleteTransaction(String id) {
    setState(() {
      _transactions.removeWhere((tr) => tr.id == id);
    });
  }

  Widget _getIconButton(IconData icon, Function()? fn) {
    return Platform.isIOS
        ? GestureDetector(
            onTap: fn,
            child: Icon(icon),
          )
        : IconButton(
            onPressed: fn,
            icon: Icon(icon),
          );
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    bool isLandscape = mediaQuery.orientation == Orientation.landscape;

    final iconList = Platform.isIOS ? CupertinoIcons.refresh : Icons.list;
    final iconChart = Platform.isIOS ? CupertinoIcons.refresh : Icons.bar_chart;

    final PreferredSizeWidget appBar = AppBar(
      title: const Text("Despesas Pessoais"),
      backgroundColor: Theme.of(context).colorScheme.primary,
      actions: [
        if (isLandscape)
          IconButton(
            onPressed: () {
              setState(() {
                _showChart = !_showChart;
              });
            },
            icon: Icon(_showChart ? Icons.list : Icons.bar_chart),
          ),
        IconButton(
          onPressed: () => _openTransactionFormModal(context),
          icon: const Icon(Icons.add),
        ),
      ],
    );

    final avaibleHeight = mediaQuery.size.height -
        appBar.preferredSize.height -
        mediaQuery.padding.top;

    final bodyContent = SafeArea(
        child: SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (_showChart || !isLandscape)
            SizedBox(
                height: avaibleHeight * (isLandscape ? 0.75 : 0.35),
                child: Chart(recentTransactions: _recentTransactions)),
          if (!_showChart || !isLandscape)
            SizedBox(
              height: avaibleHeight * (isLandscape ? 1 : 0.65),
              child: TransactionList(
                  transactions: _transactions, onRemove: _deleteTransaction),
            ),
        ],
      ),
    ));

    final actions = [
      if (isLandscape)
        _getIconButton(_showChart ? iconList : iconChart, () {
          setState(() {
            _showChart = !_showChart;
          });
        }),
      _getIconButton(Platform.isIOS ? CupertinoIcons.add : Icons.add, () {
        setState(() {
          _showChart = !_showChart;
        });
      }),
    ];

    return Platform.isIOS
        ? CupertinoPageScaffold(
            navigationBar: CupertinoNavigationBar(
              middle: const Text('Despesas Pessoais'),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: actions,
              ),
            ),
            child: bodyContent)
        : Scaffold(
            appBar: appBar,
            body: bodyContent,
            floatingActionButton: FloatingActionButton(
              onPressed: () => _openTransactionFormModal(context),
              backgroundColor: Theme.of(context).colorScheme.secondary,
              child: const Icon(Icons.add),
            ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
          );
  }
}
