import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionForm extends StatefulWidget {
  final void Function(String, double, DateTime)? onSubmit;

  const TransactionForm({Key? key, this.onSubmit}) : super(key: key);

  @override
  State<TransactionForm> createState() => _TransactionFormState();
}

class _TransactionFormState extends State<TransactionForm> {
  final _titleController = TextEditingController();
  final _valueController = TextEditingController();
  DateTime? _selectedDate = DateTime.now();

  _submitForm() {
    final title = _titleController.text;
    final value = double.tryParse(_valueController.text);

    if (title.isEmpty || value! <= 0 || _selectedDate == null) {
      return;
    }
    widget.onSubmit!(title, value, _selectedDate!);
  }

  _showDatePicker() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2023),
            lastDate: DateTime.now())
        .then((pikedDate) {
      setState(() {
        _selectedDate = pikedDate;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
          elevation: 5,
          child: Padding(
            padding: EdgeInsets.only(
                top: 10,
                right: 10,
                left: 10,
                bottom: 10 + MediaQuery.of(context).viewInsets.bottom),
            child: Column(
              children: [
                TextField(
                  decoration: const InputDecoration(labelText: 'Título'),
                  controller: _titleController,
                  onSubmitted: (_) => _submitForm(),
                ),
                TextField(
                  decoration: const InputDecoration(labelText: 'Valor (R\$)'),
                  keyboardType: TextInputType.number,
                  controller: _valueController,
                  onSubmitted: (_) => _submitForm(),
                ),
                SizedBox(
                  height: 80,
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(_selectedDate == null
                            ? "Nenhuma data selecionada!"
                            : 'Data selecionada: ${DateFormat('dd/MM/y').format(_selectedDate!)}'),
                      ),
                      TextButton(
                          onPressed: _showDatePicker,
                          child: const Text(
                            'Selecionar Data',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ))
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ElevatedButton(
                      onPressed: _submitForm,
                      child: const Text(
                        "Nova Transação",
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    )
                  ],
                )
              ],
            ),
          )),
    );
  }
}
