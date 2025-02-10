import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:true_gym/Features/chat/data/model/message_model.dart';
import 'package:true_gym/Features/chat/presentation/cubit/get_messages/chat_cubit.dart';
import 'package:true_gym/Features/chat/presentation/view/widgets/text_message_container.dart';
import 'package:true_gym/Features/register/data/model/user.dart';

class ChatPageBody extends StatefulWidget {
  const ChatPageBody({
    super.key,
    required this.toUser,
  });
  final UserModel toUser;

  @override
  State<ChatPageBody> createState() => _ChatPageBodyState();
}

class _ChatPageBodyState extends State<ChatPageBody> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    BlocProvider.of<ChatCubit>(context).getAllMessages(widget.toUser.id!);
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: BlocBuilder<ChatCubit, ChatState>(
            builder: (context, state) {
              if (state is GetAllMessageLoading) {
                return const Center(child: CircularProgressIndicator());
              }
              if (state is GetAllMessageFaild) {
                return const Center(
                    child: Icon(
                  Icons.do_not_disturb_outlined,
                  size: 40,
                  color: Colors.red,
                ));
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

                    // بعد تحديث الرسائل، ننقل السكرول للأسفل
                    WidgetsBinding.instance
                        .addPostFrameCallback((_) => _scrollToBottom());

                    return ListView.builder(
                      controller: _scrollController,
                      itemCount: messages.length,
                      itemBuilder: (context, index) {
                        return TextMessageContainer(
                          message: messages[index],
                        );
                      },
                    );
                  },
                );
              } else {
                return const Center(child: Text("No messages yet"));
              }
            },
          ),
        ),
      ],
    );
  }
}
