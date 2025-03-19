import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:linkify/Features/home/presentation/view/widgets/post_user_data.dart';

class PostHeader extends StatelessWidget {
  const PostHeader(
      {super.key, required this.name, required this.time, required this.image});
  final String name;
  final String image;
  final String time;
  @override
  Widget build(BuildContext context) {
    return Row(children: [
      ClipOval(
          child: CachedNetworkImage(
        imageUrl: image,
        width: 45,
      )),
      const SizedBox(width: 10),
      PostUserData(name: name, time: time),
      const Spacer(),
      IconButton(onPressed: () {}, icon: const Icon(Icons.more_vert, size: 30)),
    ]);
  }
}
