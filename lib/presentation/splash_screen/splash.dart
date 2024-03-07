import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:signup_page/presentation/login/login.dart';
import 'package:signup_page/presentation/mainpagewithbar/mainpagewithbar.dart';
import 'package:signup_page/router/router_constants.dart';

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
         context.go(RouterConstants.appListRoute);
        // Navigator.pushReplacement(
        //     context, MaterialPageRoute(builder: (context) =>const MainPage()));
      } else {
        context.go(RouterConstants.loginPageRoute);
        // Navigator.pushReplacement(
        //     context, MaterialPageRoute(builder: (context) => const LoginPage()));
      }
    });
  }
}
