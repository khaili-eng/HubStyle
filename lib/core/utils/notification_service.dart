import 'dart:io';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationService {
  NotificationService._();
  static final NotificationService _instance = NotificationService._();
  factory NotificationService() => _instance;

  final FirebaseMessaging _fcm = FirebaseMessaging.instance;
  final FlutterLocalNotificationsPlugin _local =
  FlutterLocalNotificationsPlugin();

  static const AndroidNotificationChannel _channel =
  AndroidNotificationChannel(
    'high_importance_channel',
    'High Importance Notifications',
    importance: Importance.high,
  );

  Future<void> init() async {
    if (!Platform.isAndroid) return;

    const androidInit =
    AndroidInitializationSettings('@mipmap/ic_launcher');

    await _local.initialize(
      const InitializationSettings(android: androidInit),
    );

    await _local
        .resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(_channel);

    FirebaseMessaging.onMessage.listen(showFromRemote);
  }

  Future<String?> getToken() => _fcm.getToken();

  Future<void> subscribeToTopic(String topic) =>
      _fcm.subscribeToTopic(topic);

  Future<void> unsubscribeFromTopic(String topic) =>
      _fcm.unsubscribeFromTopic(topic);

  Future<void> showFromRemote(RemoteMessage message) async {
    await showLocalNotification(
      title: message.notification?.title ?? '',
      body: message.notification?.body ?? '',
    );
  }


  Future<void> showLocalNotification({
    required String title,
    required String body,
  }) async {
    const details = AndroidNotificationDetails(
      'high_importance_channel',
      'High Importance Notifications',
      importance: Importance.high,
      priority: Priority.high,
    );

    await _local.show(
      DateTime.now().millisecondsSinceEpoch,
      title,
      body,
      const NotificationDetails(android: details),
    );
  }
}
