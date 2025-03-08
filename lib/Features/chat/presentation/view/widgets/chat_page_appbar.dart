import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:linkify/core/constants/colors.dart';
import 'package:linkify/core/constants/constants.dart';

class ChatPageAppbar extends StatelessWidget implements PreferredSizeWidget {
  const ChatPageAppbar({
    super.key,
    required this.name,
    this.image,
  });

  final String name;
  final String? image;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: MyColors.mainChat,
      titleSpacing: 0,
      title: Row(
        children: [
          ClipOval(
              child: CachedNetworkImage(
            imageUrl: image != "" ? image! : Constants.defaultUserImage,
            width: 40,
          )),
          const SizedBox(width: 8),
          Text(name,
              style:
                  const TextStyle(fontSize: 19, fontWeight: FontWeight.w500)),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
