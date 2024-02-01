import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:signup_page/theme.dart';

class CustomInput extends StatelessWidget {
  const CustomInput({super.key, required this.name, required this.controller, required this.placeholder, required this.keyboardStyle});

  final String name;
  final String placeholder;
  final TextEditingController controller;
  final TextInputType keyboardStyle;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      textCapitalization: TextCapitalization.sentences,
      textInputAction: TextInputAction.next,
      keyboardType: keyboardStyle,
      decoration: InputDecoration(
          border: UnderlineInputBorder(
              borderSide: BorderSide(color: underLineColor)),
          label: Text(name),
          labelStyle: TextStyle(color: hintTextColor)),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return placeholder;
        } else {
          return null;
        }
      },
    );
  }
}
