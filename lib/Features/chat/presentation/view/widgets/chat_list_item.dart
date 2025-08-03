import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:linkify/Features/chat/presentation/view/widgets/chat_item_trailng_component.dart';
import 'package:linkify/core/constants/images.dart';
import 'package:linkify/core/shared_logic/data/models/user.dart';
import 'package:linkify/core/constants/colors.dart';

class ChatListItem extends StatelessWidget {
  const ChatListItem({
    super.key,
    required this.toUser,
  });
  final UserModel toUser;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        radius: 22,
        backgroundImage: toUser.image == ""
            ? const AssetImage(MyImages.imagesUserImage)
            : CachedNetworkImageProvider(toUser.image!),
      ),
      title: Text(
        toUser.name,
        style: const TextStyle(color: MyColors.fontColor, fontSize: 15),
      ),
      trailing: const ChatItemTrailingComponent(),
      onTap: () {
        GoRouter.of(context).push('/chatPage/${toUser.id}');
      },
    );
  }
}
