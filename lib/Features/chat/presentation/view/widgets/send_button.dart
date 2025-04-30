import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:linkify/Features/chat/presentation/cubit/send_message/send_message_cubit.dart';
import 'package:linkify/Features/chat/presentation/view/widgets/input_message_container.dart';
import 'package:linkify/core/widgets/snack_bar_widget.dart';

class SendButton extends StatelessWidget {
  const SendButton({
    super.key,
    required this.textEditingController,
    required this.widget,
  });

  final TextEditingController textEditingController;
  final InputMessageContainer widget;

  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: () async {
          textEditingController.text == ""
              ? SnackBarWidget.showSnack(context, "please write message")
              : await BlocProvider.of<SendMessageCubit>(context).sendMessage(
                  toId: widget.toUserId,
                  imageURL: null,
                  msg: textEditingController.text);
          textEditingController.clear();
        },
        icon: const Icon(
          Icons.send,
          color: Color.fromARGB(255, 68, 126, 121),
          size: 30,
        ));
  }
}
