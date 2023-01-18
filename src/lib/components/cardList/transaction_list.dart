import 'package:flutter/material.dart';
import '../../assets/fonts/fonts.dart';
import '../../models/transaction.dart';
import 'transaction_item_state.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final void Function(String) onRemove;

  const TransactionList(
      {Key? key, required this.transactions, required this.onRemove})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    return transactions.isEmpty
        ? LayoutBuilder(
            builder: (ctx, constraints) => Column(
              children: [
                SizedBox(
                  height: constraints.maxHeight * 0.05,
                ),
                FittedBox(
                    child: Text("Nenhuma transação Cadastrada!",
                        style: Fonts().cardText)),
                SizedBox(
                  height: constraints.maxHeight * 0.1,
                ),
                SizedBox(
                    height: constraints.maxHeight * 0.4,
                    child: Image.asset(
                      "lib/assets/images/waiting.png",
                      fit: BoxFit.cover,
                    )),
              ],
            ),
          )
        : SizedBox(
            height: mediaQuery.size.height * 0.5,
            child: ListView.builder(
              itemCount: transactions.length,
              itemBuilder: (context, index) {
                final tr = transactions[index];
                return TransactionItemState(
                  key: GlobalObjectKey(tr),
                  onRemove: onRemove,
                  tr: tr,
                );
              },
            ),
            // child: ListView(
            //     children: transactions.map((tr) {
            //   return TransactionItemState(
            //       key: ValueKey(tr.id),
            //       mediaQuery: mediaQuery,
            //       onRemove: onRemove,
            //       tr: tr);
            // }).toList()),
          );
  }
}
