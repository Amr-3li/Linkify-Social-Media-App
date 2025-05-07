import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:linkify/core/constants/colors.dart';
import 'package:linkify/core/constants/images.dart';

class HomePageAppBar extends StatelessWidget {
  const HomePageAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      backgroundColor: MyColors.appBarColor,
      floating: true,
      snap: true,
      leading: IconButton(
          onPressed: () {
            Scaffold.of(context).openDrawer();
          },
          icon: const Icon(
            Icons.menu,
            color: Colors.white,
            size: 30,
          )),
      actions: [
        IconButton(
          onPressed: () {
            GoRouter.of(context).push('/notificationPage');
          },
          icon: const Badge(
              smallSize: 8,
              child: Icon(Icons.notifications_outlined,
                  color: MyColors.fontColor, size: 30)),
        ),
        IconButton(
          onPressed: () {
            GoRouter.of(context).push('/chatHomePage');
          },
          icon: const Badge(
              smallSize: 8,
              child: Icon(Icons.forum_outlined,
                  color: MyColors.fontColor, size: 30)),
        )
      ],
      title: Row(
        children: [
          Image.asset(MyImages.imagesAppIcon, height: 30, width: 30),
          const SizedBox(width: 10),
          const Text(
            "Linkify",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
