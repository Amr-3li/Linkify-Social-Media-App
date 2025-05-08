import 'package:flutter/material.dart';
import 'package:linkify/Features/notifications/data/model/notification_model.dart';
import 'package:linkify/core/constants/colors.dart';
import 'package:linkify/core/constants/images.dart';
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
    return ListTile(
      onTap: null,
      tileColor: const Color.fromARGB(121, 100, 255, 219),
      leading: Stack(children: [
        const CircleAvatar(
          radius: 25,
          backgroundImage: const AssetImage(MyImages.imagesUserImage),
        ),
        Positioned(
          bottom: 0,
          right: 0,
          child: CircleAvatar(
            radius: 8,
            backgroundColor: MyColors.toMessageBorder,
            child: Icon(
                type == "love"
                    ? Icons.favorite
                    : type == "comment"
                        ? Icons.comment
                        : type == "friend request"
                            ? Icons.group_add_outlined
                            : type == "your request is accepted"
                                ? Icons.done
                                : Icons.done_all,
                color: Colors.white,
                size: 12),
          ),
        )
      ]),
      title: Text(notificationModel.fromUserName),
      subtitle: Column(
        children: [
          Text(
            notificationModel.discription,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(fontSize: 12, color: Colors.grey),
          ),
          const SizedBox(height: 5),
          type == "friend request"
              ? SizedBox(
                  width: double.infinity,
                  height: 40,
                  child: Row(
                    children: [
                      CustomButton(
                          title: "Accept", color: Colors.green, onTap: () {}),
                      const Spacer(),
                      CustomButton(
                          title: "Reject", color: Colors.red, onTap: () {}),
                    ],
                  ),
                )
              : const SizedBox(),
        ],
      ),
    );
  }
}
