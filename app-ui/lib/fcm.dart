import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:hashchecker/api.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

void localNotificationSetting() async {
  final initializationSettingsAndroid =
      AndroidInitializationSettings('@mipmap/ic_launcher');
  final initSetttings =
      InitializationSettings(android: initializationSettingsAndroid);

  flutterLocalNotificationsPlugin.initialize(initSetttings);
}

void firebaseMessagingForegroundHandler(RemoteMessage message) {
  RemoteNotification? notification = message.notification;
  AndroidNotification? android = message.notification?.android;

  if (notification != null && android != null) {
    final androidNotiDetails = AndroidNotificationDetails(
        'dexterous.com.flutter.local_notifications', notification.title!,
        importance: Importance.max, priority: Priority.max);

    final details = NotificationDetails(android: androidNotiDetails);

    flutterLocalNotificationsPlugin.show(
        notification.hashCode, notification.title, notification.body, details);
  }
}
