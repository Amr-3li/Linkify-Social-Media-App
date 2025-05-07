import 'package:flutter/material.dart';
import 'package:linkify/Features/notifications/presentation/views/widgets/notificaion_appbar.dart';
import 'package:linkify/Features/notifications/presentation/views/widgets/notification_body.dart';

class NotificationPage extends StatelessWidget {
  const NotificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        backgroundColor: Colors.white,
        appBar: NotificationAppbar(),
        body: NotificationBody());
  }
}
