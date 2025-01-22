import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:true_gym/Features/chat/data/model/chat_item_model.dart';
import 'package:true_gym/Features/chat/presentation/view/widgets/chat_list_item.dart';
import 'package:true_gym/Features/register/data/model/user.dart';
import 'package:true_gym/Features/register/data/web_servecies/auth_ser_imp.dart';

class ChatHomeBody extends StatefulWidget {
  const ChatHomeBody({super.key});

  @override
  State<ChatHomeBody> createState() => _ChatHomeBodyState();
}

class _ChatHomeBodyState extends State<ChatHomeBody> {
  @override
  Widget build(BuildContext context) {
    List<ChatItemModel> chatItemsTest = [
      ChatItemModel(
          name: "Ahmed", lastMessage: "Hello", unreadCount: 1, time: "10:30"),
      ChatItemModel(
          name: "Ahmed", lastMessage: "Hello", unreadCount: 1, time: "10:30"),
      ChatItemModel(
          name: "Ahmed", lastMessage: "Hello", unreadCount: 1, time: "10:30"),
      ChatItemModel(
          name: "Ahmed", lastMessage: "Hello", unreadCount: 1, time: "10:30"),
    ];
    List<UserModel> users = [];
    return StreamBuilder(
      stream: FirebaseFirestore.instance.collection("users").snapshots(),
      //that called in Auth web ser class
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final data = snapshot.data?.docs;
          users = data?.map((e) => UserModel.fromJson(e.data())).toList() ?? [];
        }
        if (users.isEmpty) {
          return const Center(child: const Text("not user exist"));
        }
        return ListView.builder(
          itemCount: users.length,
          itemBuilder: (context, index) {
            return ChatListItem(chatItem: users[index]);
          },
        );
      },
      // child: ListView.builder(
      //   itemCount: chatItemsTest.length,
      //   itemBuilder: (context, index) {
      //     return ChatListItem(chatItem: chatItemsTest[index]);
      //   },
      // ),
    );
  }
}
