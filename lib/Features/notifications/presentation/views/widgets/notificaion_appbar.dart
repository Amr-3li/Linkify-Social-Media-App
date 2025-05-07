import 'package:flutter/material.dart';
import 'package:linkify/core/constants/colors.dart';

class NotificationAppbar extends StatelessWidget
    implements PreferredSizeWidget {
  const NotificationAppbar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
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
        style: TextStyle(
            color: Colors.white, fontWeight: FontWeight.bold, fontSize: 23),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
