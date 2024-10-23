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
      child: Container(
        padding: const EdgeInsets.all(7),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: isLove
              ? const Color.fromARGB(150, 114, 89, 87)
              : const Color.fromARGB(100, 98, 98, 98),
        ),
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
      ),
    );
  }
}
