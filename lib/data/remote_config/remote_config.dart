import 'package:firebase_remote_config/firebase_remote_config.dart';

class FirebaseRemoteConfigClass {
  final remoteConfig = FirebaseRemoteConfig.instance;

  Future initializeConfig() async {

    await remoteConfig.fetchAndActivate();
    return remoteConfig.getString('time_expiry');
  }


}
