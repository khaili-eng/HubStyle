import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class EmptyNotificationsView extends StatelessWidget {
  const EmptyNotificationsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Lottie.asset(
            'assets/animations/empty_notifications.json',
            width: 240,
          ),
          const SizedBox(height: 20),
          const Text(
            "No notifications",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 6),
          const Text(
            "You're all caught up 🎉",
            style: TextStyle(color: Colors.grey),
          ),
        ],
      ),
    );
  }
}
