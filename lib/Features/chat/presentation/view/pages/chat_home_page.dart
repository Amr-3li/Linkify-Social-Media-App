import 'package:flutter/material.dart';
import 'package:linkify/Features/chat/presentation/view/widgets/chat_appbar.dart';
import 'package:linkify/Features/chat/presentation/view/widgets/chat_dialog.dart';
import 'package:linkify/Features/chat/presentation/view/widgets/chat_home_body.dart';
import 'package:linkify/core/constants/colors.dart';

class ChatHomePage extends StatelessWidget {
  const ChatHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.backgroundColor,
      body: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) => [
                const ChatAppbar(),
              ],
          body: const ChatHomeBody()),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
              context: context, builder: (context) => const AddChatDialog());
        },
        backgroundColor: MyColors.mainChat,
        child: const Icon(Icons.add),
      ),
    );
  }
}
