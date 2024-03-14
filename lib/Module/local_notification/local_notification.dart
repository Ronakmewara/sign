import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';

class LocalNotificationDemo extends StatefulWidget {
  const LocalNotificationDemo({super.key});

  @override
  State<LocalNotificationDemo> createState() => _LocalNotificationDemoState();
}

class _LocalNotificationDemoState extends State<LocalNotificationDemo> {
  triggerNotification() {
    AwesomeNotifications().createNotification(
        content: NotificationContent(
            id: 10,
            channelKey: 'basic_notification',
            title: 'Simple Notification',
            body: 'its for testing purpose'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Local Notification Demo'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: triggerNotification,
          child: const Text('Tap For a Notification'),
        ),
      ),
    );
  }
}
