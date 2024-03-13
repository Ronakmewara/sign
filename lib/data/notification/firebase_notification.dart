import 'package:firebase_messaging/firebase_messaging.dart';

class FirebaseNotification{
   static final _firebaseMessaging = FirebaseMessaging.instance;

   static Future init()async{
      await _firebaseMessaging.requestPermission(
         alert:  true,
         announcement: true,
         badge: true,
         carPlay: false,
         criticalAlert: false,
         sound: true
      );
      final token = await _firebaseMessaging.getToken();
      print("device Token : $token " );
   }
}