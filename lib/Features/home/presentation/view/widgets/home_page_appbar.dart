import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:linkify/Features/notifications/data/repositories/get_notifications_repo.dart';
import 'package:linkify/Features/notifications/presentation/cubit/get_notifications/get_notifications_cubit.dart';
import 'package:linkify/core/constants/images.dart';
import 'package:linkify/core/dependicy_injection/get_it.dart';
import 'package:linkify/core/exports/app_router.dart';

class HomePageAppBar extends StatelessWidget {
  const HomePageAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      backgroundColor: Theme.of(context).colorScheme.primary,
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
        BlocProvider(
          create: (context) =>
              GetNotificationsCubit(gitItInstanse<GetNotificationsRepo>())
                ..noOfUnreadNotifications(),
          child: BlocBuilder<GetNotificationsCubit, GetNotificationsState>(
              builder: (context, state) {
            return IconButton(
                onPressed: () {
                  GoRouter.of(context).push('/notificationPage');
                },
                icon: state is GetUnreadNotificationsSuccess &&
                        state.noOfUnreadNotifications > 0
                    ? Badge.count(
                        count: state.noOfUnreadNotifications,
                        smallSize: 8,
                        child: Icon(Icons.notifications_outlined,
                            color: Theme.of(context).colorScheme.inverseSurface,
                            size: 30))
                    : const Icon(
                        Icons.notifications_outlined,
                        size: 30,
                      ));
          }),
        ),
        IconButton(
          onPressed: () {
            GoRouter.of(context).push('/chatHomePage');
          },
          icon: Badge(
              smallSize: 8,
              child: Icon(Icons.forum_outlined,
                  color: Theme.of(context).colorScheme.inverseSurface,
                  size: 30)),
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
