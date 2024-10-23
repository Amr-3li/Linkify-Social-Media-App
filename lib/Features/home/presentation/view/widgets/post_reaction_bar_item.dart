import 'package:flutter/material.dart';

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
      child: Row(children: [
        isLove
            ? Icon(icon, color: Colors.red)
            : Icon(
                icon,
                color: Colors.black,
              ),
        const SizedBox(width: 5),
        Text(
          text,
          style: const TextStyle(color: Colors.black),
        ),
      ]),
    );
  }
}
