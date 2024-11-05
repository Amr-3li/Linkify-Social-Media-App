import 'package:flutter/material.dart';
import 'package:true_gym/core/consts.dart';

class ChatHomePage extends StatelessWidget {
  const ChatHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.backgroundColor,
      body: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) => [
                const SliverAppBar(
                  backgroundColor: MyColors.appBarColor,
                  titleSpacing: 0.0,
                  leading: SizedBox(),
                  title: Text("Chats",
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  elevation: 2,
                  floating: true,
                  snap: true,
                  shadowColor: MyColors.shadowColor,
                  toolbarHeight: 40,
                ),
              ],
          body: const ChatHomePageBody()),
    );
  }
}

class ChatHomePageBody extends StatelessWidget {
  const ChatHomePageBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: MyColors.backgroundColor,
      child: const Center(child: Text("Chats")),
    );
  }
}
