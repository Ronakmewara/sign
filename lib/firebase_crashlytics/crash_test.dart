import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';

class CrashTest extends StatelessWidget {
  const CrashTest({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Firebase Crashlytics"),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            FirebaseCrashlytics.instance.crash();
          },
          child: const Text("Make Me Crash"),
        ),
      ),
    );
  }
}
