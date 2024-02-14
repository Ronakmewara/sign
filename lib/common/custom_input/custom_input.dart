import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:signup_page/theme/theme.dart';

class CustomInput extends StatelessWidget {
  const CustomInput(
      {super.key,
      required this.name,
      required this.controller,
      required this.placeholder,
      required this.keyboardStyle,
      required this.regexp,
      required this.regexNotMatchMessage,
      required this.obscureText, this.suffixIcon});

  final String name;
  final String placeholder;
  final TextEditingController controller;
  final TextInputType keyboardStyle;
  final String regexp;
  final String regexNotMatchMessage;
  final bool obscureText;
  final Widget? suffixIcon;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: obscureText,
      controller: controller,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      textCapitalization: TextCapitalization.sentences,
      textInputAction: TextInputAction.next,

      keyboardType: keyboardStyle,
      decoration: InputDecoration(
          border: UnderlineInputBorder(
              borderSide: BorderSide(color: underLineColor)),
          label: Text(name),
          labelStyle: TextStyle(color: hintTextColor),
        suffixIcon : suffixIcon,),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return placeholder;
        } else if (regexp.isNotEmpty) {
          if (!RegExp(regexp).hasMatch(value)) {
            return regexNotMatchMessage;
          }
        }

        return null;
      },
    );
  }
}
