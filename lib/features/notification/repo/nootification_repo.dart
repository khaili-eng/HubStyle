import '../data/model/notification_model.dart';
//for edit work
abstract class NotificationRepo {
  Future<String?> getFCMToken();
  Future<void> sendDeviceTokenToServer({required String userId, required String token});
  Future<void> updateDeviceToken({required String userId, String? oldToken, required String newToken});
  Future<void> removeDeviceToken({required String userId, required String token});

  Future<List<NotificationModel>> getUserNotifications({required String userId});
  Future<void> markNotificationAsRead({required String userId, required String notificationId});
  Future<void> markAllNotificationsAsRead({required String userId});
  Future<void> deleteNotification({required String userId, required String notificationId});

  Future<Map<String, bool>> getSubscribedTopics({required String userId});
  Future<void> subscribeToTopic(String topic);
  Future<void> unsubscribeFromTopic(String topic);

  Future<void> showLocalNotification({required String title, required String body});
}
