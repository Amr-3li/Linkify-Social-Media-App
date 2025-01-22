import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:true_gym/Features/chat/data/model/chat_item_model.dart';
import 'package:true_gym/Features/chat/presentation/view/pages/chat_screan.dart';
import 'package:true_gym/Features/chat/presentation/view/widgets/chat_item_trailng_component.dart';
import 'package:true_gym/Features/register/data/model/user.dart';
import 'package:true_gym/core/constants/consts.dart';

class ChatListItem extends StatelessWidget {
  const ChatListItem({
    super.key,
    required this.chatItem,
  });
  final UserModel chatItem;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        radius: 22,
        backgroundImage: chatItem.image == ""
            ? const CachedNetworkImageProvider(
                'https://www.pngitem.com/pimgs/m/150-1503945_transparent-user-png-default-user-image-png-png.png')
            : CachedNetworkImageProvider(chatItem.image!),
      ),
      title: Text(
        chatItem.fname,
        style: const TextStyle(color: MyColors.fontColor, fontSize: 15),
      ),
      trailing: const ChatItemTrailingComponent(
        number: 10,
        time: "dasdasd",
      ),
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return const ChatScrean();
        }));
      },
    );
  }
}
