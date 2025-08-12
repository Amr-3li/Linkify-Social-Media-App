import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:linkify/Features/chat/data/repository/chat_repo.dart';
import 'package:linkify/Features/chat/presentation/cubit/chat_users/chat_users_cubit.dart';
import 'package:linkify/Features/chat/presentation/cubit/message_count/message_count_cubit.dart';
import 'package:linkify/Features/chat/presentation/view/widgets/chat_list_item.dart';
import 'package:linkify/core/constants/animation.dart';
import 'package:linkify/core/constants/constants.dart';
import 'package:linkify/core/dependicy_injection/get_it.dart';
import 'package:lottie/lottie.dart';
import 'package:skeletonizer/skeletonizer.dart';

class ChatHomeBody extends StatelessWidget {
  const ChatHomeBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChatUsersCubit, ChatUsersState>(
      builder: (context, state) {
        if (state is ChatUsersLoading) {
          return Skeletonizer(
            child: ListView.builder(
              itemCount: 10,
              itemBuilder: (context, index) {
                return const ListTile(
                  leading: CircleAvatar(radius: 20),
                  title: Text(Constants.skeltonizerTextSmall2),
                );
              },
            ),
          );
        } else if (state is ChatUsersLoaded && state.users.isNotEmpty) {
          final users = state.users;
          return ListView.builder(
            itemCount: users.length,
            itemBuilder: (context, index) {
              return BlocProvider(
                create: (context) =>
                    MessageCountCubit(gitItInstanse<ChatRepo>())
                      ..countUnreadMessage(users[index].id!),
                child: ChatListItem(toUser: users[index]),
              );
            },
          );
        } else {
          return Center(
              child:
                  Lottie.asset(MyAnimation.animationsNotExist, repeat: false));
        }
      },
    );
  }
}
