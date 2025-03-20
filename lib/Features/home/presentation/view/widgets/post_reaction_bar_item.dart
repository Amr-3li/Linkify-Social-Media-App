import 'package:flutter/material.dart';
import 'package:linkify/core/constants/colors.dart';

class PostReactionBarItem extends StatelessWidget {
  const PostReactionBarItem(
      {super.key,
      required this.onTap,
      this.isLove = false,
      required this.icon,
      required this.text});
  final Function() onTap;
  final bool isLove;
  final IconData icon;
  final String text;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
        ),
        child: Row(children: [
          Icon(
            icon,
            color:
                isLove ? Colors.red : const Color.fromARGB(255, 111, 111, 111),
            size: 25,
          ),
          const SizedBox(width: 8),
          Text(
            text,
            style: const TextStyle(
                color: MyColors.fromMessageBorder,
                fontSize: 16,
                fontWeight: FontWeight.w600),
          ),
        ]),
      ),
    );
  }
}
