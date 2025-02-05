import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:true_gym/Features/chat/data/model/message_model.dart';
import 'package:true_gym/Features/chat/presentation/cubit/cubit/chat_cubit.dart';
import 'package:true_gym/Features/chat/presentation/view/widgets/input_message_container.dart';
import 'package:true_gym/Features/chat/presentation/view/widgets/text_message_container.dart';
import 'package:true_gym/Features/register/data/model/user.dart';

class ChatPageBody extends StatelessWidget {
  const ChatPageBody({
    super.key,
    required this.toUser,
  });
  final UserModel toUser;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: BlocBuilder<ChatCubit, ChatState>(
            builder: (context, state) {
              if (state is GetAllMessageLoading) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is GetAllMessageSuccess) {
                return StreamBuilder(
                  stream: state.messages,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                      return const Center(child: Text("No messages yet"));
                    }
                    final messages = snapshot.data!.docs
                        .map((doc) => MessageModel.fromJson(doc.data()))
                        .toList();
                    return ListView.builder(
                      itemCount: messages.length,
                      itemBuilder: (context, index) {
                        return TextMaessageContainer(
                          message: messages[index],
                        );
                      },
                    );
                  },
                );
              } else if (state is GetAllMessageFaild) {
                return Center(child: Text(state.message));
              }
              return const Center(child: Text("Start a conversation"));
            },
          ),
        ),
        InputMessageContainer(toUser: toUser),
      ],
    );
  }
}
