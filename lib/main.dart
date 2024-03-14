import 'dart:ui';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:device_preview/device_preview.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';

import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:month_year_picker/month_year_picker.dart';
import 'package:signup_page/Module/get_it_demo/locator.dart';
import 'package:signup_page/data/notification/firebase_notification.dart';
import 'package:signup_page/firebase_options.dart';
import 'package:signup_page/router/router_config.dart';
import 'package:signup_page/theme/theme.dart';
import 'package:sizer/sizer.dart';

// Future _firebaseBackgroundMessage(RemoteMessage message) async {
//   if (message.notification != null) {
//     print('some notification received!');
//   }
// }

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  AwesomeNotifications().initialize(null, [
    NotificationChannel(
        channelKey: 'basic_notification',
        channelName: 'Basic Notification',
        channelDescription: 'Notification for basic Test!')
  ],
  debug: true);
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  FlutterError.onError = (errorDetails) {
    FirebaseCrashlytics.instance.recordFlutterFatalError(errorDetails);
  };

  PlatformDispatcher.instance.onError = (error, stack) {
    FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
    return true;
  };
  // FirebaseNotification.init();
  // FirebaseMessaging.onBackgroundMessage(_firebaseBackgroundMessage);
  //
  // FirebaseMessaging.onMessage.listen((RemoteMessage message) {
  //   if (message.notification != null) {
  //     print("Got a message in foreground");
  //   }
  // });
  //
  // final RemoteMessage? message =
  //     await FirebaseMessaging.instance.getInitialMessage();
  //
  // if (message != null) {
  //   print("Launched from terminated state");
  // }
  setupLocator();
  await Hive.initFlutter();
  runApp(DevicePreview(
    enabled: true,
    builder: (context) => const MyApp(), // Wrap your app
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();

    AwesomeNotifications().isNotificationAllowed().then((isAllowed){
      if(!isAllowed){
        AwesomeNotifications().requestPermissionToSendNotifications();
      }
    });
  }
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
