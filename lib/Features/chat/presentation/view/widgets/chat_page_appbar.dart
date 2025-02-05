import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:true_gym/core/constants/colors.dart';
import 'package:true_gym/core/constants/constants.dart';

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
      backgroundColor: MyColors.appBarColor,
      centerTitle: true,
      title: Row(
        children: [
          CachedNetworkImage(imageUrl: image ?? Constants.defaultUserImage),
          Text(name),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
