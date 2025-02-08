// import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:true_gym/Features/chat/presentation/cubit/send_message/send_message_cubit.dart';
import 'package:true_gym/Features/register/data/model/user.dart';
import 'package:true_gym/core/constants/colors.dart';

class InputMessageContainer extends StatefulWidget {
  const InputMessageContainer({
    super.key,
    required this.toUser,
  });
  final UserModel toUser;
  @override
  State<InputMessageContainer> createState() => _InputMessageContainerState();
}

class _InputMessageContainerState extends State<InputMessageContainer> {
  bool isTyping = false;
  bool isEmpty = true;
  TextEditingController textEditingController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Card(
            shadowColor: MyColors.shadowColor,
            child: Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: textEditingController,
                    minLines: 1,
                    maxLines: 3,
                    style: const TextStyle(),
                    onTapOutside: (event) {
                      FocusManager.instance.primaryFocus?.unfocus();
                    },
                    onChanged: (value) => setState(() {}),
                    decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: "  type a message",
                        hintStyle: TextStyle(
                            color: Color.fromARGB(255, 127, 127, 127))),
                  ),
                ),
                textEditingController.text != ""
                    ? const SizedBox()
                    : IconButton(
                        onPressed: () {}, icon: const Icon(Icons.image)),
                textEditingController.text != ""
                    ? const SizedBox()
                    : IconButton(
                        onPressed: () {}, icon: const Icon(Icons.camera_alt)),
              ],
            ),
          ),
        ),
        textEditingController.text == ""
            ? const SizedBox()
            : IconButton(
                onPressed: () {
                  BlocProvider.of<SendMessageCubit>(context).sendMessage(
                      toId: widget.toUser.id!,
                      imageURL: "",
                      msg: textEditingController.text);
                  textEditingController.clear();
                },
                icon: const Icon(
                  Icons.send,
                  color: Color.fromARGB(255, 68, 126, 121),
                  size: 30,
                ))
      ],
    );
  }
}
