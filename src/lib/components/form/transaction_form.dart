import 'package:cod3r_expenses/components/buttons/adaptative_button.dart';
import 'package:cod3r_expenses/components/datepicker/datepicker.dart';
import 'package:cod3r_expenses/components/textfield/textfield.dart';
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
  DateTime? selectedDate = DateTime.now();

  _submitForm() {
    final title = _titleController.text;
    final value = double.tryParse(_valueController.text);

    if (title.isEmpty || value! <= 0 || selectedDate == null) {
      return;
    }
    widget.onSubmit!(title, value, selectedDate!);
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
                AdaptativeTextField(
                  controller: _titleController,
                  label: 'Título',
                  submitForm: (_) => _submitForm(),
                ),
                AdaptativeTextField(
                  controller: _titleController,
                  label: 'Valor (R\$)',
                  submitForm: (_) => _submitForm(),
                  keyboardType: TextInputType.number,
                ),
                AdaptativeDatePicker(
                  selectedDate: selectedDate,
                  onDateChanged: (newDate) {
                    setState(() {
                      selectedDate = newDate;
                    });
                  },
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    AdaptativeButton(
                        label: "Nova Transação", onPressed: _submitForm),
                  ],
                )
              ],
            ),
          )),
    );
  }
}
