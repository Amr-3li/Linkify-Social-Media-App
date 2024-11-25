import 'package:flutter/material.dart';
import 'package:true_gym/core/utils/consts.dart';

class ChatItemTrailingComponent extends StatelessWidget {
  const ChatItemTrailingComponent({
    super.key,
    required this.time,
    required this.number,
  });
  final String time;
  final int number;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CircleAvatar(
          radius: 8,
          backgroundColor: Colors.green,
          child: Text(
            "$number",
            style: const TextStyle(fontSize: 10, color: Colors.white),
          ),
        ),
        Text(
          time,
          style: TextStyle(
              color: MyColors.fontColor.withOpacity(0.5), fontSize: 12),
        ),
      ],
    );
  }
}
