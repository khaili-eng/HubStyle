import 'package:flutter/material.dart';

class NotificationDeleteBackground extends StatelessWidget {
  const NotificationDeleteBackground({super.key});

  @override
  Widget build(BuildContext context) {
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
}
