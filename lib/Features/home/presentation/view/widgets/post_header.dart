import 'package:flutter/material.dart';

class PostHeader extends StatelessWidget {
  const PostHeader({super.key, required this.name});
  final String name;

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      ClipOval(
          child: Container(
        height: 50,
        width: 50,
        color: Colors.blueGrey,
      )),
      const SizedBox(width: 10),
      Text(name,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          )),
      const Spacer(),
      IconButton(onPressed: () {}, icon: const Icon(Icons.more_vert, size: 30)),
    ]);
  }
}
