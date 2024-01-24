import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

ThemeData theme() {
  return ThemeData(
    textTheme: titleTextTheme(),
  );
}

TextTheme titleTextTheme() {
  return GoogleFonts.nunitoSansTextTheme(const TextTheme(
    titleLarge: TextStyle(fontSize: 38, fontWeight: FontWeight.w400),
  ));
}

var primaryColor = const Color.fromRGBO(0, 85, 46, 1);
var underLineColor = const Color.fromARGB(106, 158, 158, 158);
var hintTextColor = const Color.fromARGB(183, 158, 158, 158);
var buttonLightGreen = const Color.fromRGBO(223, 234, 228, 1); //r
var buttonLightGreenBorder = const Color.fromRGBO(0, 85, 46, 0.7215686274509804);