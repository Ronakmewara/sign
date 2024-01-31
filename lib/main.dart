import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:signup_page/homepage.dart';

import 'package:signup_page/login.dart';
import 'package:signup_page/splash.dart';

import 'package:signup_page/theme.dart';

void main() {
  runApp( DevicePreview(
      enabled: true,
      builder: (context) => const MyApp(), // Wrap your app
  ) );
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {




    return MaterialApp(
        locale: DevicePreview.locale(context),
        builder: DevicePreview.appBuilder,
        debugShowCheckedModeBanner: false,
        title: 'Signup Page',
        theme: theme(),
        home: const SplashScreen());
        // home: const SettingPage());
  }
}
