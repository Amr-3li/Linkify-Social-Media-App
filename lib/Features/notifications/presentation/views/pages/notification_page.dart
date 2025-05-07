import 'package:flutter/material.dart';
import 'package:linkify/core/constants/colors.dart';

class NotificationPage extends StatelessWidget {
  const NotificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: MyColors.appBarColor,
          elevation: 0,
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back, color: Colors.white, size: 30),
          ),
          title: const Text(
            "Notifications",
            style: const TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold, fontSize: 23),
          ),
        ),
        body: const Center(child: const Text("Notification")));
  }
}

class NotificationAppbar extends StatelessWidget {
  const NotificationAppbar({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
