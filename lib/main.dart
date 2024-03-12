import 'dart:ui';

import 'package:device_preview/device_preview.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:month_year_picker/month_year_picker.dart';
import 'package:signup_page/Module/get_it_demo/locator.dart';
import 'package:signup_page/firebase_options.dart';
import 'package:signup_page/router/router_config.dart';
import 'package:signup_page/theme/theme.dart';
import 'package:sizer/sizer.dart';

import 'Module/beerlist_app_without_bloc/beer_infinite_listing.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  FlutterError.onError = (errorDetails) {
    FirebaseCrashlytics.instance.recordFlutterFatalError(errorDetails);
  };
  // Pass all uncaught asynchronous errors that aren't handled by the Flutter framework to Crashlytics
  PlatformDispatcher.instance.onError = (error, stack) {
    FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
    return true;
  };
  setupLocator();
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
      return MaterialApp.router(

          routerConfig: MyRouter().router,
            localizationsDelegates: const [
              // GlobalMaterialLocalizations.delegate,
              MonthYearPickerLocalizations.delegate
            ],
            locale: DevicePreview.locale(context),
            builder: DevicePreview.appBuilder,
            debugShowCheckedModeBanner: false,
            title: 'Signup Page',
            theme: theme(),

      );
    });

    // home: const SettingPage());
  }
}
