import 'package:flutter/material.dart';
import 'package:true_gym/Features/chat/data/model/chat_item_model.dart';
import 'package:true_gym/Features/chat/presentation/view/widgets/chat_list_item.dart';

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
