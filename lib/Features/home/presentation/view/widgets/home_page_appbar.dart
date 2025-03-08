import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:linkify/core/constants/colors.dart';

class HomePageAppBar extends StatelessWidget {
  const HomePageAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      centerTitle: true,
      backgroundColor: MyColors.appBarColor,
      floating: true,
      snap: true,
      leading: IconButton(
          onPressed: () {
            Scaffold.of(context).openDrawer();
          },
          icon: const Icon(Icons.menu)),
      actions: [
        IconButton(
          onPressed: () {
            GoRouter.of(context).push('/chatHomePage');
          },
          icon: Badge.count(
              count: 10,
              child: const Icon(Icons.forum_outlined, color: Colors.black)),
        )
      ],
      title: const Text(
        "Home",
        style: TextStyle(color: Colors.black),
      ),
    );
  }
}
