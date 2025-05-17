import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationService {
  final FirebaseMessaging _messaging = FirebaseMessaging.instance;
  final FlutterLocalNotificationsPlugin _localNotificationsPlugin =
  FlutterLocalNotificationsPlugin();

  Future<void> initialize() async {

    await _messaging.requestPermission();

    FirebaseMessaging.onBackgroundMessage(handleBackgroundMessage);

    const AndroidNotificationChannel channel = AndroidNotificationChannel(
      'high_importance_channel',
      'High Importance Notifications',
      importance: Importance.max,
    );

    await _localNotificationsPlugin
        .resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      _showNotification(message);
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      _handleNotificationTap(message);
    });

    final RemoteMessage? initialMessage =
    await _messaging.getInitialMessage();
    if (initialMessage != null) {
      _handleNotificationTap(initialMessage);
    }
  }

  void _showNotification(RemoteMessage message) {
    final notification = message.notification;
    final android = message.notification?.android;

    if (notification != null && android != null) {
      _localNotificationsPlugin.show(
        notification.hashCode,
        notification.title,
        notification.body,
        NotificationDetails(
          android: AndroidNotificationDetails(
            'high_importance_channel',
            'High Importance Notifications',
            icon: 'launch_background',
          ),
        ),
      );
    }
  }

  void _handleNotificationTap(RemoteMessage message) {
    // Navigate to a specific screen or perform an action
    print('Notification tapped: ${message.data}');
  }
}

Future<void> handleBackgroundMessage(RemoteMessage message) async {
  // Handle background message
  print('Handling a background message: ${message.data}');
  print('Handling a background message title: ${message.notification?.title}');
  print('Handling a background message body: ${message.notification?.body}');
}