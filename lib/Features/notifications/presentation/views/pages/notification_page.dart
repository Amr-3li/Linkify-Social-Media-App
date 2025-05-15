import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:linkify/Features/notifications/presentation/cubit/get_notifications/get_notifications_cubit.dart';
import 'package:linkify/Features/notifications/presentation/views/widgets/notificaion_appbar.dart';
import 'package:linkify/Features/notifications/presentation/views/widgets/notification_body.dart';

class NotificationPage extends StatelessWidget {
  const NotificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: const NotificationAppbar(),
        body: RefreshIndicator(
            onRefresh: () async {
              await context
                  .read<GetNotificationsCubit>()
                  .loadInitialNotifications();
            },
            child: const NotificationBody()));
  }
}
