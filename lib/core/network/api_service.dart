import 'package:dio/dio.dart';
import 'package:untitled7/features/notification/data/model/notification_model.dart';

class ApiService {
  final Dio _dio;

  ApiService({required String baseUrl})
      : _dio = Dio(BaseOptions(
    baseUrl: baseUrl,
    connectTimeout: const Duration(seconds: 10),
    receiveTimeout: const Duration(seconds: 10),
    headers: {
      "Content-Type": "application/json",
    },
  ));
  Future<void> sendDeviceTokenToServer({
    required String userId,
    required String token,
  }) async {
    await _dio.post(
      "/device-tokens",
      data: {
        "user_id": userId,
        "device_token": token,
      },
    );
  }
  Future<void> updateDeviceToken({
    required String userId,
    required String? oldToken,
    required String newToken,
  }) async {
    await _dio.put(
      "/device-tokens",
      data: {
        "user_id": userId,
        "old_token": oldToken,
        "new_token": newToken,
      },
    );
  }
  Future<void> removeDeviceToken({
    required String userId,
    required String token,
  }) async {
    await _dio.delete(
      "/device-tokens",
      data: {
        "user_id": userId,
        "device_token": token,
      },
    );
  }


  Future<List<NotificationModel>> getUserNotifications(String userId) async {
    final res = await _dio.get("/users/$userId/notifications");
    return res.data["data"]; // يجب أن يكون response = { data: [...] }
  }


  Future<void> markNotificationAsRead({
    required String userId,
    required String notificationId,
  }) async {
    await _dio.post(
      "/notifications/$notificationId/read",
      data: {
        "user_id": userId,
      },
    );
  }


  Future<void> markAllNotificationsAsRead(String userId) async {
    await _dio.post("/users/$userId/notifications/mark-all-read");
  }


  Future<void> deleteNotification({
    required String userId,
    required String notificationId,
  }) async {
    await _dio.delete(
      "/notifications/$notificationId",
      data: {
        "user_id": userId,
      },
    );
  }


  Future<Map<String, bool>> getSubscribedTopics(String userId) async {
    final res = await _dio.get("/users/$userId/topics");

    return Map<String, bool>.from(res.data["topics"]);
  }
}
