import 'package:flutter/material.dart';

class PostHeader extends StatelessWidget {
  const PostHeader({super.key, required this.name, required this.time});
  final String name;
  final String image = "assets/images/user.png";
  final String time;
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
      PostData(name: name, time: time),
      const Spacer(),
      IconButton(onPressed: () {}, icon: const Icon(Icons.more_vert, size: 30)),
    ]);
  }
}

class PostData extends StatelessWidget {
  const PostData({
    super.key,
    required this.name,
    required this.time,
  });

  final String name;
  final String time;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(name,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
            )),
        const SizedBox(height: 2),
        Text(time, style: const TextStyle(fontSize: 13, color: Colors.grey)),
      ],
    );
  }
}
