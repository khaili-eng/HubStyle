import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:animate_do/animate_do.dart';
import '../manager/notification_cubit.dart';
import '../manager/notification_state.dart';

import '../widget/empty_notification_view.dart';
import '../widget/notification_item.dart';


class NotificationsPage extends StatelessWidget {
  const NotificationsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F7FB),
      appBar: AppBar(
        title: const Text("Notifications"),
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.done_all_rounded),
            tooltip: "Mark all as read",
            onPressed: () {
              context.read<NotificationCubit>()
                  .markAllAsRead("USER_ID");
            },
          ),
        ],
      ),
      body: BlocBuilder<NotificationCubit, NotificationState>(
        builder: (context, state) {
          if (state is NotificationLoading) {
            return const LinearProgressIndicator();
          }

          if (state.notifications.isEmpty) {
            return const EmptyNotificationsView();
          }

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: state.notifications.length,
            itemBuilder: (context, index) {
              final notification = state.notifications[index];

              return FadeInUp(
                duration: const Duration(milliseconds: 350),
                delay: Duration(milliseconds: index * 70),
                child: NotificationItem(notification: notification),
              );
            },
          );
        },
      ),
    );
  }
}
