import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/model/notification_model.dart';
import '../manager/notification_cubit.dart';

class NotificationItem extends StatelessWidget {
  final NotificationModel notification;

  const NotificationItem({
    super.key,
    required this.notification,
  });

  @override
   Widget build(BuildContext context) {
     return Dismissible(
      key: ValueKey(notification.id),
      direction: DismissDirection.endToStart,
      background: _deleteBackground(),
      onDismissed: (_) {
        context.read<NotificationCubit>()
            .deleteNotification("USER_ID", notification.id);
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 14),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: notification.isRead
              ? Colors.white
              : const Color(0xFFEAF2FF),
          borderRadius: BorderRadius.circular(18),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _icon(),
            const SizedBox(width: 12),
            Expanded(child: _content(context)),
          ],
        ),
      ),
    );
  }

  Widget _icon() {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: notification.isRead
            ? Colors.grey.shade200
            : Colors.blue.shade100,
        shape: BoxShape.circle,
      ),
      child: Icon(
        Icons.notifications_rounded,
        color: notification.isRead ? Colors.grey : Colors.blue,
        size: 22,
      ),
    );
  }

  Widget _content(BuildContext context) {
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
              _formatDate(notification.createdAt),
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

  Widget _deleteBackground() {
    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      alignment: Alignment.centerRight,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        color: Colors.redAccent,
        borderRadius: BorderRadius.circular(18),
      ),
      child: const Icon(
        Icons.delete_outline,
        color: Colors.white,
        size: 26,
      ),
    );
  }

  String _formatDate(DateTime date) {
    return "${date.day}/${date.month}/${date.year}";
  }
}
