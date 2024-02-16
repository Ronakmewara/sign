import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:signup_page/common/custom_button/custom_button.dart';
import 'package:signup_page/common/custom_input/custom_input.dart';
import 'package:signup_page/presentation/login/login_form/login_form.dart';
import 'package:signup_page/presentation/mainpagewithbar/mainpagewithbar.dart';
import 'package:signup_page/presentation/signup/signup.dart';
import 'package:signup_page/theme/theme.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Stack(
        children: [
          Image.asset(
            'asset/image/appbackground.jpg',
            fit: BoxFit.cover,
          ),
          Padding(
            padding: const EdgeInsets.all(45),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 100,
                ),
                Text(
                  'Welcome\nBack',
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(
                        color: primaryColor,
                      ),
                  textAlign: TextAlign.left,
                ),
                const Center(
                  child: LoginForm()
                ),
              ],
            ),
          )
        ],
      ),
    ));
  }
}
