import 'package:flutter/material.dart';

class TransactionForm extends StatefulWidget {
  final void Function(String, double)? onSubmit;

  const TransactionForm({Key? key, this.onSubmit}) : super(key: key);

  @override
  State<TransactionForm> createState() => _TransactionFormState();
}

class _TransactionFormState extends State<TransactionForm> {
  final titleController = TextEditingController();

  final valueController = TextEditingController();

  _submitForm() {
    final title = titleController.text;
    final value = double.tryParse(valueController.text);

    if (title.isEmpty || value! <= 0) {
      return;
    }
    widget.onSubmit!(title, value);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
        elevation: 5,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              TextField(
                decoration: const InputDecoration(labelText: 'Título'),
                controller: titleController,
                onSubmitted: (_) => _submitForm(),
              ),
              TextField(
                decoration: const InputDecoration(labelText: 'Valor (R\$)'),
                keyboardType: TextInputType.number,
                controller: valueController,
                onSubmitted: (_) => _submitForm(),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                      onPressed: _submitForm,
                      child: Text(
                        "Nova transação",
                        style: TextStyle(
                            color: Theme.of(context).colorScheme.primary),
                      )),
                ],
              )
            ],
          ),
        ));
  }
}
