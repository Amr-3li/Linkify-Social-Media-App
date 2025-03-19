import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class PostUserData extends StatelessWidget {
  const PostUserData({
    super.key,
    required this.name,
    required this.time,
  });

  final String name;
  final String time;

  @override
  Widget build(BuildContext context) {
    DateTime dateTime = DateTime.fromMicrosecondsSinceEpoch(int.parse(time));
    final DateFormat formatter = DateFormat('dd-MMM HH:mm');
    String formattedDate = formatter.format(dateTime);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(name,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
            )),
        const SizedBox(height: 2),
        Text(formattedDate,
            style: const TextStyle(fontSize: 13, color: Colors.grey)),
      ],
    );
  }
}
