import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:io';

class AdaptativeTextField extends StatelessWidget {
  final TextEditingController controller;
  final String? label;
  final Function(String) submitForm;
  final TextInputType keyboardType;
  const AdaptativeTextField(
      {Key? key,
      required this.controller,
      required this.submitForm,
      this.label,
      this.keyboardType = TextInputType.text})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Platform.isIOS
        ? Padding(
            padding: const EdgeInsets.only(bottom: 10.0),
            child: CupertinoTextField(
              placeholder: label,
              controller: controller,
              onSubmitted: submitForm,
              keyboardType: keyboardType,
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 12),
            ),
          )
        : TextField(
            decoration: InputDecoration(labelText: label),
            controller: controller,
            onSubmitted: submitForm,
            keyboardType: keyboardType,
          );
  }
}
