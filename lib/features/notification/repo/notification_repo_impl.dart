import '../../../core/network/api_service.dart';
import '../../../core/utils/notification_service.dart';
import '../data/model/notification_model.dart';
import 'nootification_repo.dart';

class NotificationRepoImpl implements NotificationRepo {
  final NotificationService service;
  final ApiService api;

  NotificationRepoImpl({required this.service, required this.api});

  @override
  Future<String?> getFCMToken() => service.getToken();


  @override
  Future<void> sendDeviceTokenToServer({required String userId, required String token}) {
    return api.sendDeviceTokenToServer(userId: userId,token:  token);
  }

  @override
  Future<void> updateDeviceToken({required String userId, String? oldToken, required String newToken}) {
    return api.updateDeviceToken(userId: userId,oldToken:  oldToken,newToken:  newToken);
  }

  @override
  Future<void> removeDeviceToken({required String userId, required String token}) {
    return api.removeDeviceToken(userId: userId, token: token);
  }

  @override
  Future<List<NotificationModel>> getUserNotifications({required String userId}) {
    return api.getUserNotifications(userId);
  }

  @override
  Future<void> markNotificationAsRead({required String userId, required String notificationId}) {
    return api.markNotificationAsRead(userId: userId,notificationId:  notificationId);
  }

  @override
  Future<void> markAllNotificationsAsRead({required String userId}) {
    return api.markAllNotificationsAsRead(userId);
  }

  @override
  Future<void> deleteNotification({required String userId, required String notificationId}) {
    return api.deleteNotification(userId: userId,notificationId:  notificationId);
  }

  @override
  Future<Map<String, bool>> getSubscribedTopics({required String userId}) {
    return api.getSubscribedTopics(userId);
  }

  @override
  Future<void> subscribeToTopic(String topic) {
    return service.subscribeToTopic(topic);
  }

  @override
  Future<void> unsubscribeFromTopic(String topic) {
    return service.unsubscribeFromTopic(topic);
  }

  @override
  Future<void> showLocalNotification({required String title, required String body}) {
    return service.showLocalNotification(title: title, body: body);
  }
}