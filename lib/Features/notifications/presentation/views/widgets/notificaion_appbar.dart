import 'package:flutter/material.dart';
import 'package:linkify/core/constants/constants.dart';
import 'package:linkify/core/exports/app_router.dart';

class NotificationAppbar extends StatelessWidget
    implements PreferredSizeWidget {
  const NotificationAppbar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      leading: IconButton(
        onPressed: () {
          context.read<GetNotificationsCubit>().readAllNotifications();
          GoRouter.of(context).pop();
        },
        icon: const Icon(Icons.arrow_back, color: Colors.white, size: 30),
      ),
      actions: [
        IconButton(
          icon: const Icon(
            Icons.remove_red_eye,
            color: Colors.white,
            size: 30,
          ),
          onPressed: () async {
            await context.read<GetNotificationsCubit>().readAllNotifications();
          },
        ),
      ],
      title: const Text(
        Constants.notifications,
        style: TextStyle(
            color: Colors.white, fontWeight: FontWeight.bold, fontSize: 23),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
