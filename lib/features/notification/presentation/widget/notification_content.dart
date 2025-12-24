import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/model/notification_model.dart';
import '../manager/notification_cubit.dart';


class NotificationContent extends StatelessWidget {
  final NotificationModel notification;

  const NotificationContent({
    super.key,
    required this.notification,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          notification.title,
          style: TextStyle(
            fontSize: 15,
            fontWeight:
            notification.isRead ? FontWeight.w500 : FontWeight.bold,
          ),
        ),
        const SizedBox(height: 6),
        Text(
          notification.body,
          style: const TextStyle(
            fontSize: 13,
            color: Colors.black54,
            height: 1.4,
          ),
        ),
        const SizedBox(height: 10),
        Row(
          children: [
            Text(
              formatNotificationDate(notification.createdAt),
              style: const TextStyle(
                fontSize: 11,
                color: Colors.grey,
              ),
            ),
            const Spacer(),
            if (!notification.isRead)
              GestureDetector(
                onTap: () {
                  context.read<NotificationCubit>().markAsRead(
                    "USER_ID",
                    notification.id,
                  );
                },
                child: const Text(
                  "Mark as read",
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.blue,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
          ],
        ),
      ],
    );
  }

  String formatNotificationDate(DateTime date) {
    return "${date.day}/${date.month}/${date.year}";
  }
}

