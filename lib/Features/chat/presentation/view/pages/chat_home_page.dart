import 'package:flutter/material.dart';
import 'package:true_gym/Features/chat/presentation/view/widgets/chat_appbar.dart';
import 'package:true_gym/Features/chat/presentation/view/widgets/chat_home_body.dart';
import 'package:true_gym/core/constants/colors.dart';

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
    );
  }
}
