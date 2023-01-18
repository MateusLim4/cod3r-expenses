import 'dart:math';

import 'package:intl/intl.dart';
import 'package:flutter/material.dart';

import '../../assets/fonts/fonts.dart';
import '../../models/transaction.dart';

class TransactionItemState extends StatefulWidget {
  const TransactionItemState({
    Key? key,
    required this.onRemove,
    required this.tr,
  }) : super(key: key);

  final void Function(String p1) onRemove;
  final Transaction tr;

  @override
  State<TransactionItemState> createState() => _TransactionItemStateState();
}

class _TransactionItemStateState extends State<TransactionItemState> {
  static const colors = [
    Colors.red,
    Colors.purple,
    Colors.green,
    Colors.orange,
    Colors.blue
  ];

  Color? _backgroundColor;

  @override
  void initState() {
    super.initState();
    int i = Random().nextInt(colors.length);
    _backgroundColor = colors[i];
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);

    return Card(
      elevation: 5,
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 5),
      child: ListTile(
        trailing: mediaQuery.size.width > 400
            ? TextButton.icon(
                onPressed: () => widget.onRemove(widget.tr.id),
                icon: const Icon(
                  Icons.delete,
                  color: Colors.grey,
                ),
                label: const Text(
                  "Excluir",
                  style: TextStyle(color: Colors.grey),
                ),
              )
            : IconButton(
                icon: const Icon(
                  Icons.delete,
                  color: Colors.grey,
                ),
                onPressed: (() => widget.onRemove(widget.tr.id)),
              ),
        leading: CircleAvatar(
          backgroundColor: _backgroundColor,
          radius: 30,
          child: Padding(
            padding: const EdgeInsets.all(6.0),
            child: FittedBox(
              child: Text(
                "R\$${widget.tr.value.toStringAsFixed(2)}",
                style: Fonts().quicksandBold,
              ),
            ),
          ),
        ),
        title: Text(
          widget.tr.title,
          style: Fonts().cardText,
        ),
        subtitle: Text(DateFormat('d MMMM y').format(widget.tr.date)),
      ),
    );
  }
}
