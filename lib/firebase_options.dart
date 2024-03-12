// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        return macos;
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyBHeiKP7_i-MIxe5zHIspb6rdtBBg0jNDM',
    appId: '1:580333281956:web:05db1606879ec7eac4fc31',
    messagingSenderId: '580333281956',
    projectId: 'fir-first-993ca',
    authDomain: 'fir-first-993ca.firebaseapp.com',
    storageBucket: 'fir-first-993ca.appspot.com',
    measurementId: 'G-PVH87Q4GYW',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBktA-TH5udp1QCzjNJtpBZepcLTD2MW4o',
    appId: '1:580333281956:android:fc3588481f69fd6bc4fc31',
    messagingSenderId: '580333281956',
    projectId: 'fir-first-993ca',
    storageBucket: 'fir-first-993ca.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDjR_gm25XArt74T3XR4wcTvHu7IPjjTyU',
    appId: '1:580333281956:ios:640c880552b0551bc4fc31',
    messagingSenderId: '580333281956',
    projectId: 'fir-first-993ca',
    storageBucket: 'fir-first-993ca.appspot.com',
    iosBundleId: 'com.example.signupPage',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDjR_gm25XArt74T3XR4wcTvHu7IPjjTyU',
    appId: '1:580333281956:ios:c3f86d030436737ac4fc31',
    messagingSenderId: '580333281956',
    projectId: 'fir-first-993ca',
    storageBucket: 'fir-first-993ca.appspot.com',
    iosBundleId: 'com.example.signupPage.RunnerTests',
  );
}
