import 'package:flutter/material.dart';
import 'package:true_gym/core/utils/consts.dart';

class ChatAppbar extends StatelessWidget {
  const ChatAppbar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      backgroundColor: MyColors.appBarColor,
      titleSpacing: 0.0,
      title: const Text("Chats", style: TextStyle(fontWeight: FontWeight.bold)),
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
