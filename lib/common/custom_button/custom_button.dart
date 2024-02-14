import 'package:flutter/material.dart';

import '../../theme/theme.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({super.key, required this.text});
  final String text;
  @override
  Widget build(BuildContext context) {
    return   Container(
      decoration: BoxDecoration(
          color: primaryColor,
          borderRadius: BorderRadius.circular(40)),
      height: 50,
      width: 400,
      child: Center(
        child: Text(
          text,
          style: Theme.of(context)
              .textTheme
              .titleLarge!
              .copyWith(
              fontSize: 18, color: Colors.white),
        ),
      ),
    );
  }
}
