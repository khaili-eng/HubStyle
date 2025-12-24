import 'package:equatable/equatable.dart';
import '../../data/model/notification_model.dart';

abstract class NotificationState extends Equatable {
  final String? fcmToken;
  final List<NotificationModel> notifications;
  final bool hasUnreadNotifications;
  final String? errorMessage;
  final Map<String, bool> subscribedTopics;
  final bool isNotificationEnabled;
  const NotificationState({
    this.fcmToken,
    this.notifications = const [],
    this.hasUnreadNotifications = false,
    this.errorMessage,
    this.subscribedTopics = const {},
    this.isNotificationEnabled = true,
  });
  int get unreadCount => notifications.where((n) => !n.isRead).length;

  List<NotificationModel> get unreadNotifications =>
      notifications.where((n) => !n.isRead).toList();

  List<NotificationModel> get readNotifications =>
      notifications.where((n) => n.isRead).toList();

  bool get hasNotifications => notifications.isNotEmpty;
  @override
  List<Object?> get props => [
    fcmToken,
    notifications,
    hasUnreadNotifications,
    errorMessage,
    subscribedTopics,
    isNotificationEnabled,
  ];
}
class NotificationInitial extends NotificationState {
  const NotificationInitial() : super();
}
class NotificationLoading extends NotificationState {
  const NotificationLoading({
    super.notifications,
    super.fcmToken,
    super.subscribedTopics,
    super.isNotificationEnabled,
  });
}
class NotificationLoaded extends NotificationState {
  const NotificationLoaded({
    required List<NotificationModel> notifications,
    String? fcmToken,
    Map<String, bool> subscribedTopics = const {},
    bool hasUnreadNotifications = false,
    bool isNotificationEnabled = true,
  }) : super(
    notifications: notifications,
    fcmToken: fcmToken,
    hasUnreadNotifications: hasUnreadNotifications,
    subscribedTopics: subscribedTopics,
    isNotificationEnabled: isNotificationEnabled,
  );

  NotificationLoaded copyWith({
    String? fcmToken,
    List<NotificationModel>? notifications,
    bool? hasUnreadNotifications,
    Map<String, bool>? subscribedTopics,
    bool? isNotificationEnabled,
  }) {
    return NotificationLoaded(
      notifications: notifications ?? this.notifications,
      fcmToken: fcmToken ?? this.fcmToken,
      hasUnreadNotifications:
      hasUnreadNotifications ?? this.hasUnreadNotifications,
      subscribedTopics: subscribedTopics ?? this.subscribedTopics,
      isNotificationEnabled: isNotificationEnabled ?? this.isNotificationEnabled,
    );
  }
}
class NotificationError extends NotificationState {
  const NotificationError(
      String message, {
        super.notifications,
      }) : super(errorMessage: message);
}
class NotificationUpdating extends NotificationState {
  const NotificationUpdating({
    super.notifications,
    super.fcmToken,
    super.subscribedTopics,
    super.isNotificationEnabled,
  });
}
class NotificationTokenRefreshing extends NotificationState {
  const NotificationTokenRefreshing({
    super.notifications,
    super.fcmToken,
    super.subscribedTopics,
    super.isNotificationEnabled,
  });
}
