import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:signup_page/infinite_list.dart';

import 'package:signup_page/splash.dart';

import 'package:signup_page/theme.dart';

void main() async {
await Hive.initFlutter();
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
        home: const InfiniteList());
        // home: const SettingPage());
  }
}
