import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:month_year_picker/month_year_picker.dart';
import 'package:signup_page/presentation/login/login.dart';
import 'package:signup_page/presentation/mainpagewithbar/mainpagewithbar.dart';
import 'package:signup_page/theme/theme.dart';
import 'package:sizer/sizer.dart';

void main() async {
  await Hive.initFlutter();
  runApp(DevicePreview(
    enabled: true,
    builder: (context) => const MyApp(), // Wrap your app
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Sizer(builder: (context, orientation, deviceType) {
      return MaterialApp(
            localizationsDelegates: [
              // GlobalMaterialLocalizations.delegate,
              MonthYearPickerLocalizations.delegate
            ],
            locale: DevicePreview.locale(context),
            builder: DevicePreview.appBuilder,
            debugShowCheckedModeBanner: false,
            title: 'Signup Page',
            theme: theme(),
            home: const LoginPage()
      );
    });

    // home: const SettingPage());
  }
}
