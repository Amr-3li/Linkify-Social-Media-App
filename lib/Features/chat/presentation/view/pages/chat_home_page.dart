import 'package:flutter/material.dart';
import 'package:linkify/Features/chat/data/repository/chat_users_repo.dart';
import 'package:linkify/Features/chat/presentation/cubit/chat_users/chat_users_cubit.dart';
import 'package:linkify/Features/chat/presentation/view/widgets/chat_appbar.dart';
import 'package:linkify/Features/chat/presentation/view/widgets/chat_home_body.dart';
import 'package:linkify/core/exports/app_router.dart';

class ChatHomePage extends StatelessWidget {
  const ChatHomePage({super.key});
  static const String routeName = '/chatHomePage';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) => [
                const ChatAppbar(),
              ],
          body: BlocProvider(
            create: (context) =>
                ChatUsersCubit(gitItInstanse<ChatUsersRepo>())..getChatUsers(),
            child: const ChatHomeBody(),
          )),
    );
  }
}
