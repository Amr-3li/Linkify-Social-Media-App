import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:linkify/Features/notifications/data/model/notification_model.dart';
import 'package:linkify/core/constants/colors.dart';
import 'package:linkify/core/constants/images.dart';
import 'package:linkify/core/helper/get_time_ago.dart';
import 'package:linkify/core/widgets/custom_button.dart';

class NotificationItem extends StatelessWidget {
  const NotificationItem({
    super.key,
    required this.notificationModel,
  });
  final NotificationModel notificationModel;
  @override
  Widget build(BuildContext context) {
    String type = notificationModel.type;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: ListTile(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        onTap: () {
          if (type == "friendRequest" || type == "yourRequestIsAccepted") {
            GoRouter.of(context)
                .push('/profilePage/${notificationModel.fromUserId}');
          } else {
            GoRouter.of(context).push('/postPage/${notificationModel.postId}');
          }
        },
        tileColor: const Color.fromARGB(121, 100, 255, 219),
        trailing: Text(
            GetTimeAgo.getTimeAgo(notificationModel.time)
                .replaceAll(" ago", ""),
            style: const TextStyle(fontSize: 10)),
        leading: Stack(children: [
          const CircleAvatar(
            radius: 25,
            backgroundImage: AssetImage(MyImages.imagesUserImage),
          ),
          Positioned(
            bottom: 0,
            right: 0,
            child: CircleAvatar(
              radius: 10,
              backgroundColor: MyColors.toMessageBorder,
              child: Icon(
                  type == "addLove"
                      ? Icons.favorite
                      : type == "addComment"
                          ? Icons.comment
                          : type == "friendRequest"
                              ? Icons.group_add
                              : type == "yourRequestIsAccepted"
                                  ? Icons.group_rounded
                                  : Icons.done_all,
                  color: Colors.white,
                  size: 12),
            ),
          )
        ]),
        title: Text(notificationModel.fromUserName,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 17)),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              notificationModel.discription,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontSize: 15, color: MyColors.fontColor),
            ),
            const SizedBox(height: 5),
            type == "friendRequest"
                ? SizedBox(
                    width: double.infinity,
                    height: 35,
                    child: Row(
                      children: [
                        Expanded(
                          child: CustomButton(
                              title: "Accept",
                              color: Colors.green,
                              onTap: () {}),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: CustomButton(
                              title: "Reject", color: Colors.red, onTap: () {}),
                        ),
                      ],
                    ),
                  )
                : const SizedBox(),
          ],
        ),
      ),
    );
  }
}
