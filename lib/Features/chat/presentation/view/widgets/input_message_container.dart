import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_sound/public/flutter_sound_player.dart';
import 'package:flutter_sound/public/flutter_sound_recorder.dart';
import 'package:true_gym/Features/chat/presentation/cubit/record/record_cubit.dart';
import 'package:true_gym/Features/chat/presentation/cubit/send_message/send_message_cubit.dart';
import 'package:true_gym/Features/chat/presentation/view/widgets/send_button.dart';
import 'package:true_gym/Features/chat/presentation/view/widgets/send_image_icon.dart';
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
  late FlutterSoundRecorder _audioRecorder;
  late FlutterSoundPlayer _audioPlayer;
  bool isRecording = false;
  late String recordedFilePath;

  @override
  void initState() {
    super.initState();
    _audioRecorder = FlutterSoundRecorder();
    _audioPlayer = FlutterSoundPlayer();
    recordedFilePath = "";
  }

  @override
  void dispose() {
    super.dispose();
    textEditingController.dispose();
    _audioRecorder.closeRecorder();
    _audioPlayer.closePlayer();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RecordCubit, RecordState>(
      builder: (context, state) {
        return Row(
          children: [
            Expanded(
              child: Card(
                shadowColor: MyColors.shadowColor,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    state is RecordStart
                        ? const Text("Recording...",
                            style: TextStyle(color: Colors.green))
                        : Expanded(
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
                          )),
                    textEditingController.text != "" || state is RecordStart
                        ? const SizedBox()
                        : SendImageIcon(
                            toUser: widget.toUser,
                          ),
                    textEditingController.text != ""
                        ? const SizedBox()
                        : state is RecordStart
                            ? Row(
                                children: [
                                  IconButton(
                                      onPressed: () async {
                                        recordedFilePath =
                                            await BlocProvider.of<RecordCubit>(
                                                    context)
                                                .stopRecord(_audioRecorder);

                                        await BlocProvider.of<SendMessageCubit>(
                                                context)
                                            .sendMessage(
                                                toId: widget.toUser.id!,
                                                recordURL:
                                                    File(recordedFilePath),
                                                msg: "");
                                        print(recordedFilePath);
                                      },
                                      icon: const Icon(
                                        Icons.send,
                                        color: Colors.red,
                                      )),
                                  IconButton(
                                      onPressed: () async {
                                        await BlocProvider.of<RecordCubit>(
                                                context)
                                            .cancelRecord(_audioRecorder);
                                      },
                                      icon: const Icon(
                                        Icons.delete,
                                        color: Colors.blueGrey,
                                        size: 25,
                                      )),
                                ],
                              )
                            : IconButton(
                                onPressed: () async {
                                  await BlocProvider.of<RecordCubit>(context)
                                      .startRecord(_audioRecorder);
                                },
                                icon: const Icon(Icons.mic,
                                    color: Color.fromARGB(255, 168, 11, 0)),
                              ),
                  ],
                ),
              ),
            ),
            textEditingController.text == ""
                ? const SizedBox()
                : SendButton(
                    textEditingController: textEditingController,
                    widget: widget)
          ],
        );
      },
    );
  }
}
