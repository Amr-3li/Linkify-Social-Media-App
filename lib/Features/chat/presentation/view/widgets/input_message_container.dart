// import 'package:flutter/material.dart';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:true_gym/Features/chat/data/repository/chat_repo.dart';
import 'package:true_gym/Features/chat/presentation/cubit/send_message/send_message_cubit.dart';
import 'package:true_gym/Features/chat/presentation/view/pages/image_confirm_message.dart';
import 'package:true_gym/Features/chat/presentation/view/widgets/send_button.dart';
import 'package:true_gym/Features/register/data/model/user.dart';
import 'package:true_gym/Features/register/data/repository/image_repo.dart';
import 'package:true_gym/core/constants/colors.dart';
import 'package:true_gym/core/helper/pick_image.dart';
import 'package:true_gym/get_it.dart';

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
  late File imageFile;
  TextEditingController textEditingController = TextEditingController();
  @override
  void dispose() {
    super.dispose();
    textEditingController.dispose();
  }

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
                            color: Color.fromARGB(255, 147, 147, 147))),
                  ),
                ),
                textEditingController.text != ""
                    ? const SizedBox()
                    : IconButton(
                        onPressed: () async {
                          await PickImage().pickImage((value) {
                            imageFile = value;
                          });
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => BlocProvider(
                                        create: (context) => SendMessageCubit(
                                            gitItInstanse<ChatRepo>(),
                                            gitItInstanse<ImageRepo>()),
                                        child: ImageConfirmMessage(
                                            toUser: widget.toUser,
                                            imageFile: imageFile),
                                      )));
                        },
                        icon: const Icon(Icons.image),
                      ),
                textEditingController.text != ""
                    ? const SizedBox()
                    : IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.camera_alt),
                      ),
              ],
            ),
          ),
        ),
        textEditingController.text == ""
            ? const SizedBox()
            : SendButton(
                textEditingController: textEditingController, widget: widget)
      ],
    );
  }
}
