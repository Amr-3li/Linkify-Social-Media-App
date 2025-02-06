import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:true_gym/Features/chat/presentation/view/widgets/chat_list_item.dart';
import 'package:true_gym/Features/register/data/model/user.dart';

class ChatHomeBody extends StatefulWidget {
  const ChatHomeBody({super.key});

  @override
  State<ChatHomeBody> createState() => _ChatHomeBodyState();
}

class _ChatHomeBodyState extends State<ChatHomeBody> {
  @override
  Widget build(BuildContext context) {
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
          return const Center(child: Text("not user exist"));
        }
        return ListView.builder(
          itemCount: users.length,
          itemBuilder: (context, index) {
            print("id :  ${users[index].fname}   ");
            return users[index].id != FirebaseAuth.instance.currentUser!.uid
                ? ChatListItem(toUser: users[index])
                : const SizedBox();
          },
        );
      },
    );
  }
}
