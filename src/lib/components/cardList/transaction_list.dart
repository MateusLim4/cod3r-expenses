import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../assets/fonts/fonts.dart';
import '../../models/transaction.dart';

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
                return Card(
                  elevation: 5,
                  margin:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 5),
                  child: ListTile(
                    trailing: mediaQuery.size.width > 400
                        ? TextButton.icon(
                            onPressed: () => onRemove(tr.id),
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
                            onPressed: (() => onRemove(tr.id)),
                          ),
                    leading: CircleAvatar(
                      backgroundColor: Theme.of(context).colorScheme.primary,
                      radius: 30,
                      child: Padding(
                        padding: const EdgeInsets.all(6.0),
                        child: FittedBox(
                          child: Text(
                            "R\$${tr.value.toStringAsFixed(2)}",
                            style: Fonts().quicksandBold,
                          ),
                        ),
                      ),
                    ),
                    title: Text(
                      tr.title,
                      style: Fonts().cardText,
                    ),
                    subtitle: Text(DateFormat('d MMMM y').format(tr.date)),
                  ),
                );
              },
            ),
          );
  }
}
