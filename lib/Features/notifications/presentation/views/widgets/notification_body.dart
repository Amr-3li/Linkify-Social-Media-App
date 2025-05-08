import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:linkify/Features/notifications/data/model/notification_model.dart';
import 'package:linkify/Features/notifications/presentation/cubit/get_notifications/get_notifications_cubit.dart';
import 'package:linkify/Features/notifications/presentation/views/widgets/notification_item.dart';

class NotificationBody extends StatefulWidget {
  const NotificationBody({super.key});

  @override
  State<NotificationBody> createState() => _NotificationBodyState();
}

class _NotificationBodyState extends State<NotificationBody> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    context.read<GetNotificationsCubit>().loadInitialNotifications();

    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
          _scrollController.position.maxScrollExtent - 300) {
        context.read<GetNotificationsCubit>().loadMoreNotifications();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetNotificationsCubit, GetNotificationsState>(
      builder: (context, state) {
        if (state is GetNotificationsLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is GetNotificationsFaild) {
          return Center(child: Text("Error: ${state.message}"));
        } else if (state is GetNotificationsSuccess) {
          final List<NotificationModel> notifications = state.notifications;
          final bool isLoadingMore = state.isLoadingMore;

          return ListView.builder(
            controller: _scrollController,
            itemCount: notifications.length + (isLoadingMore ? 1 : 0),
            itemBuilder: (context, index) {
              if (index < notifications.length) {
                return NotificationItem(
                    notificationModel: notifications[index]);
              } else {
                return const Padding(
                  padding: EdgeInsets.symmetric(vertical: 16),
                  child: Center(child: CircularProgressIndicator()),
                );
              }
            },
          );
        } else {
          return const SizedBox(); // Initial or unknown state
        }
      },
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}
