import 'package:flutter/material.dart';
import 'package:linkify/core/constants/colors.dart';
import 'package:linkify/core/constants/constants.dart';

class ChatAppbar extends StatelessWidget {
  const ChatAppbar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      backgroundColor: MyColors.mainChat,
      titleSpacing: 0.0,
      title: const Text(Constants.chats,
          style: TextStyle(fontWeight: FontWeight.bold)),
      elevation: 2,
      floating: true,
      snap: true,
      shadowColor: MyColors.shadowColor,
      toolbarHeight: 40,
      actions: [
        IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.search,
              size: 30,
            )),
      ],
    );
  }
}
