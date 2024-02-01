import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:signup_page/login.dart';
import 'package:signup_page/mainpagewithbar.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool? isLoggedIn;

  @override
  void initState() {
    super.initState();
    _test();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child:  
      Icon((Icons.energy_savings_leaf) , size: 100,)),
    );
  }

  void _test() {
    Future.delayed(const Duration(seconds: 3), () async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      isLoggedIn = prefs.getBool('isLogged');
      if (isLoggedIn == true) {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) =>const MainPage()));
      } else {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => const LoginPage()));
      }
    });
  }
}
