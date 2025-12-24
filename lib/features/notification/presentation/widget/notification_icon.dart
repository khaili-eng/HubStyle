import 'package:flutter/material.dart';

class NotificationIcon extends StatelessWidget {
  final bool isRead;

  const NotificationIcon({
    super.key,
    required this.isRead,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: isRead ? Colors.grey.shade200 : Colors.blue.shade100,
        shape: BoxShape.circle,
      ),
      child: Icon(
        Icons.notifications_rounded,
        color: isRead ? Colors.grey : Colors.blue,
        size: 22,
      ),
    );
  }
}
