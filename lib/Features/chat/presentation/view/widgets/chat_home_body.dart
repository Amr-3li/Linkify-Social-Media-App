import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:true_gym/Features/chat/data/model/chat_item_model.dart';
import 'package:true_gym/Features/chat/presentation/view/widgets/chat_item_trailng_component.dart';
import 'package:true_gym/core/consts.dart';

class ChatHomeBody extends StatelessWidget {
  const ChatHomeBody({super.key});

  @override
  Widget build(BuildContext context) {
    List<ChatItemModel> chatItems = [
      ChatItemModel(
          name: "Ahmed", lastMessage: "Hello", unreadCount: 1, time: "10:30"),
      ChatItemModel(
          name: "Ahmed", lastMessage: "Hello", unreadCount: 1, time: "10:30"),
      ChatItemModel(
          name: "Ahmed", lastMessage: "Hello", unreadCount: 1, time: "10:30"),
      ChatItemModel(
          name: "Ahmed", lastMessage: "Hello", unreadCount: 1, time: "10:30"),
    ];
    return ListView.builder(
      itemCount: chatItems.length,
      itemBuilder: (context, index) {
        return ChatListItem(chatItem: chatItems[index]);
      },
    );
  }
}

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
        radius: 20,
        backgroundImage: chatItem.imageUrl == ""
            ? const NetworkImage(
                'https://www.pngitem.com/pimgs/m/150-1503945_transparent-user-png-default-user-image-png-png.png')
            : CachedNetworkImageProvider(chatItem.imageUrl ?? ""),
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
      onTap: () {},
    );
  }
}
