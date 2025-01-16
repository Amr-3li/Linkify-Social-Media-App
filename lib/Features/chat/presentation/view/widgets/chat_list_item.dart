import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:true_gym/Features/chat/data/model/chat_item_model.dart';
import 'package:true_gym/Features/chat/presentation/view/pages/chat_screan.dart';
import 'package:true_gym/Features/chat/presentation/view/widgets/chat_item_trailng_component.dart';
import 'package:true_gym/core/constants/consts.dart';

class ChatListItem extends StatelessWidget {
  const ChatListItem({
    super.key,
    required this.chatItem,
  });
  final ChatItemModel chatItem;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        radius: 22,
        backgroundImage: chatItem.imageUrl == null
            ? const CachedNetworkImageProvider(
                'https://www.pngitem.com/pimgs/m/150-1503945_transparent-user-png-default-user-image-png-png.png')
            : CachedNetworkImageProvider(chatItem.imageUrl!),
      ),
      title: Text(
        chatItem.name,
        style: const TextStyle(color: MyColors.fontColor, fontSize: 15),
      ),
      subtitle: Text(
        chatItem.lastMessage,
        style:
            TextStyle(color: MyColors.fontColor.withOpacity(0.5), fontSize: 12),
      ),
      trailing: ChatItemTrailingComponent(
        number: chatItem.unreadCount,
        time: chatItem.time,
      ),
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return const ChatScrean();
        }));
      },
    );
  }
}
