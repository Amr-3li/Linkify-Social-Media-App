import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:linkify/Features/chat/presentation/view/widgets/chat_page_appbar.dart';
import 'package:linkify/Features/chat/presentation/view/widgets/chat_page_body.dart';
import 'package:linkify/Features/register/presentation/cubit/user_data/user_cubit.dart';

class ChatPage extends StatelessWidget {
  const ChatPage({super.key, required this.toUserId});
  final String toUserId;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserCubit, UserState>(
      builder: (context, state) {
        return Scaffold(
          appBar: state is UserLoaded
              ? ChatPageAppbar(name: state.user.name, image: state.user.image!)
              : const ChatPageAppbar(name: "", image: ""),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: ChatPageBody(toUserId: toUserId),
          ),
        );
      },
    );
  }
}
