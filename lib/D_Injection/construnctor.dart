import 'package:flutter/material.dart';
import 'package:signup_page/D_Injection/DataService.dart';
import 'package:signup_page/D_Injection/constructor_di.dart';


class ConstructorInjection extends StatelessWidget {
  const ConstructorInjection({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: PrintList(dataService: DataService()),
    );
  }
}
