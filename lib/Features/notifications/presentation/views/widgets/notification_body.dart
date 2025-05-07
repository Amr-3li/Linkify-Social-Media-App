import 'package:flutter/material.dart';
import 'package:linkify/Features/notifications/presentation/views/widgets/notification_item.dart';

class NotificationBody extends StatelessWidget {
  const NotificationBody({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: 10,
        itemBuilder: (context, index) => const NotificationItem());
  }
}
