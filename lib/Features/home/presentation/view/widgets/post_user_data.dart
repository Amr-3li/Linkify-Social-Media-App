import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:linkify/Features/profile/presentation/view/profile.dart';

class PostUserData extends StatelessWidget {
  const PostUserData({
    super.key,
    required this.name,
    required this.time,
    required this.userId,
  });

  final String name, userId;
  final String time;

  @override
  Widget build(BuildContext context) {
    DateTime dateTime = DateTime.fromMicrosecondsSinceEpoch(int.parse(time));
    final DateFormat formatter = DateFormat('dd-MMM HH:mm');
    String formattedDate = formatter.format(dateTime);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        InkWell(
          onTap: () {
            GoRouter.of(context).push('${ProfilePage.routeName}/$userId');
          },
          child: Text(
            name,
            style: TextStyle(
                fontSize: 16,
                color: Theme.of(context).colorScheme.onSurface,
                fontWeight: FontWeight.w500),
          ),
        ),
        const SizedBox(height: 2),
        Text(formattedDate,
            style: const TextStyle(fontSize: 13, color: Colors.grey)),
      ],
    );
  }
}
