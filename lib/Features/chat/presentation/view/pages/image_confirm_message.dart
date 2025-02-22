import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:true_gym/Features/chat/presentation/cubit/send_message/send_message_cubit.dart';
import 'package:true_gym/Features/register/data/model/user.dart';

class ImageConfirmMessage extends StatefulWidget {
  const ImageConfirmMessage(
      {super.key, required this.imageFile, required this.toUser});
  final File? imageFile;
  final UserModel toUser;

  @override
  State<ImageConfirmMessage> createState() => _ImageConfirmMessageState();
}

class _ImageConfirmMessageState extends State<ImageConfirmMessage> {
  TextEditingController textEditingController = TextEditingController();
  @override
  void initState() {
    super.initState();
    if (widget.imageFile == null) {
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
          const Spacer(),
          Image.file(
            widget.imageFile!,
            fit: BoxFit.contain,
          ),
          const Spacer(),
          Row(children: [
            Expanded(
              child: TextFormField(
                controller: textEditingController,
                minLines: 1,
                maxLines: 3,
                style: const TextStyle(color: Colors.white),
                onTapOutside: (event) {
                  FocusManager.instance.primaryFocus?.unfocus();
                },
                onChanged: (value) => setState(() {}),
                decoration: const InputDecoration(
                    border: InputBorder.none,
                    hintText: "  type a message",
                    hintStyle:
                        TextStyle(color: Color.fromARGB(255, 157, 157, 157))),
              ),
            ),
            const SizedBox(width: 20),
            IconButton(
                onPressed: () async {
                  await BlocProvider.of<SendMessageCubit>(context).sendMessage(
                    toId: widget.toUser.id!,
                    imageURL: widget.imageFile,
                    msg: textEditingController.text,
                  );
                  textEditingController.clear();
                  Navigator.pop(context);
                },
                icon: const Icon(
                  Icons.send,
                  color: Color.fromARGB(255, 68, 126, 121),
                  size: 30,
                ))
          ])
        ],
      ),
    );
  }
}
