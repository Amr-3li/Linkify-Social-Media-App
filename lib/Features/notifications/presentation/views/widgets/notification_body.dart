import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:linkify/Features/notifications/data/model/notification_model.dart';
import 'package:linkify/Features/notifications/presentation/cubit/get_notifications/get_notifications_cubit.dart';
import 'package:linkify/Features/notifications/presentation/views/widgets/notification_item.dart';
import 'package:linkify/core/constants/animation.dart';
import 'package:linkify/core/constants/constants.dart';
import 'package:linkify/core/exports/app_router.dart';
import 'package:linkify/core/widgets/custom_button.dart';
import 'package:lottie/lottie.dart';
import 'package:skeletonizer/skeletonizer.dart';

class NotificationBody extends StatefulWidget {
  const NotificationBody({super.key});

  @override
  State<NotificationBody> createState() => _NotificationBodyState();
}

class _NotificationBodyState extends State<NotificationBody> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    context.read<GetNotificationsCubit>().loadInitialNotifications();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
          _scrollController.position.maxScrollExtent) {
        context.read<GetNotificationsCubit>().loadMoreNotifications();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetNotificationsCubit, GetNotificationsState>(
      builder: (context, state) {
        if (state is GetNotificationsLoading) {
          return Skeletonizer(
              containersColor: const Color.fromARGB(105, 108, 212, 196),
              child: ListView.builder(
                  itemCount: 10,
                  itemBuilder: (_, __) => const ListTile(
                      leading: CircleAvatar(
                        radius: 20,
                      ),
                      title: Padding(
                        padding: EdgeInsets.only(top: 8.0),
                        child: Text(Constants.skeltonizerTextSmall2),
                      ))));
        } else if (state is GetNotificationsSuccess &&
            state.notifications.isNotEmpty) {
          final List<NotificationModel> notifications = state.notifications;
          final bool isLoadingMore = state.isLoadingMore;

          return ListView.builder(
            controller: _scrollController,
            itemCount: notifications.length + (isLoadingMore ? 1 : 0),
            itemBuilder: (context, index) {
              if (index < notifications.length) {
                return NotificationItem(
                    notificationModel: notifications[index]);
              } else {
                return const Padding(
                  padding: EdgeInsets.symmetric(vertical: 16),
                  child: Center(child: CircularProgressIndicator()),
                );
              }
            },
          );
        } else {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Lottie.asset(MyAnimation.animationsNotExist),
                const SizedBox(height: 10),
                SizedBox(
                  width: 100,
                  height: 40,
                  child: CustomButton(
                      title: Constants.refresh.tr(),
                      color: Colors.green,
                      onTap: () async {
                        await context
                            .read<GetNotificationsCubit>()
                            .loadInitialNotifications();
                      }),
                )
              ],
            ),
          ); // Initial or unknown state
        }
      },
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}
