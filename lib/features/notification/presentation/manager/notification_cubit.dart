import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/model/notification_model.dart';
import '../../repo/nootification_repo.dart';
import 'notification_state.dart';

class NotificationCubit extends Cubit<NotificationState> {
  final NotificationRepo repo;
  final List<NotificationModel> notifications;

  NotificationCubit(this.notifications, {required this.repo}) : super(const NotificationInitial());

  Future<void> initialize(String userId) async {
    emit(NotificationLoading(
      notifications: state.notifications,
    ));

    try {
      final token = await repo.getFCMToken();
      if (token != null) {
        await repo.sendDeviceTokenToServer(userId: userId, token: token);
      }

      final notifications = await repo.getUserNotifications(userId: userId);
      final topics = await repo.getSubscribedTopics(userId: userId);

      emit(NotificationLoaded(
        notifications: notifications,
        fcmToken: token,
        subscribedTopics: topics,
        hasUnreadNotifications: notifications.any((n) => !n.isRead),
      ));
    } catch (e) {
      emit(NotificationError("Failed to initialize: $e"));
    }
  }

  Future<void> refreshToken(String userId) async {
    emit(NotificationTokenRefreshing(
      notifications: state.notifications,
      fcmToken: state.fcmToken,
    ));

    try {
      final newToken = await repo.getFCMToken();
      if (newToken != null && newToken != state.fcmToken) {
        await repo.updateDeviceToken(
          userId: userId,
          oldToken: state.fcmToken,
          newToken: newToken,
        );

        emit(NotificationLoaded(
          notifications: state.notifications,
          fcmToken: newToken,
          subscribedTopics: state.subscribedTopics,
          hasUnreadNotifications: state.hasUnreadNotifications,
        ));
      }
    } catch (e) {
      emit(NotificationError("Failed to refresh token: $e"));
    }
  }

  Future<void> fetchNotifications(String userId) async {
    emit(NotificationLoading(notifications: state.notifications));

    try {
      final notifications = await repo.getUserNotifications(userId: userId);

      emit(NotificationLoaded(
        notifications: notifications,
        fcmToken: state.fcmToken,
        subscribedTopics: state.subscribedTopics,
        hasUnreadNotifications: notifications.any((n) => !n.isRead),
      ));
    } catch (e) {
      emit(NotificationError("Error loading notifications: $e"));
    }
  }

  Future<void> markAsRead(String userId, String id) async {
    try {
      await repo.markNotificationAsRead(userId: userId, notificationId: id);

      final updated = state.notifications.map((n) {
        if (n.id == id) return n.copyWith(isRead: true);
        return n;
      }).toList();

      emit(NotificationLoaded(
        notifications: updated,
        fcmToken: state.fcmToken,
        subscribedTopics: state.subscribedTopics,
        hasUnreadNotifications: updated.any((n) => !n.isRead),
      ));
    } catch (e) {
      emit(NotificationError("Failed to update read state: $e"));
    }
  }
  Future<void> markAllAsRead(String userID) async{
    try{
      await repo.markAllNotificationsAsRead(userId:userID);
      final update = state.notifications.map((n){
        return n.copyWith(isRead: true);

        }).toList();
      emit(NotificationUpdating(notifications: update));
    }catch(e){
      emit(NotificationError("Faild to update read state:$e"));
    }
  }

  Future<void> deleteNotification(String userId, String id) async {
    try {
      await repo.deleteNotification(userId: userId, notificationId: id);

      final updated = state.notifications.where((n) => n.id != id).toList();

      emit(NotificationLoaded(
        notifications: updated,
        fcmToken: state.fcmToken,
        subscribedTopics: state.subscribedTopics,
        hasUnreadNotifications: updated.any((n) => !n.isRead),
      ));
    } catch (e) {
      emit(NotificationError("Failed to delete: $e"));
    }
  }

  Future<void> toggleTopic(String topic, bool subscribe) async {
    try {
      if (subscribe) {
        await repo.subscribeToTopic(topic);
      } else {
        await repo.unsubscribeFromTopic(topic);
      }

      final updated = Map<String, bool>.from(state.subscribedTopics);
      updated[topic] = subscribe;

      emit(NotificationLoaded(
        notifications: state.notifications,
        fcmToken: state.fcmToken,
        subscribedTopics: updated,
        hasUnreadNotifications: state.hasUnreadNotifications,
      ));
    } catch (e) {
      emit(NotificationError("Failed to update topic: $e"));
    }
  }

  Future<void> addLocalNotification(String title, String body) async {
    final newNotif = NotificationModel(
      id: "local_${DateTime.now().millisecondsSinceEpoch}",
      title: title,
      body: body,
      isRead: false,
      createdAt: DateTime.now(),
      type: "local",
      data: {},
      isLocal: true,
    );

    final updated = [newNotif, ...state.notifications];

    emit(NotificationLoaded(
      notifications: updated,
      fcmToken: state.fcmToken,
      subscribedTopics: state.subscribedTopics,
      hasUnreadNotifications: true,
    ));

    await repo.showLocalNotification(title: title, body: body);
  }

  Future<void> clearToken(String userId) async {
    try {
      if (state.fcmToken != null) {
        await repo.removeDeviceToken(
          userId: userId,
          token: state.fcmToken!,
        );
      }

      emit(const NotificationInitial());
    } catch (e) {
      emit(NotificationError("Failed to clear token: $e"));
    }
  }
}
