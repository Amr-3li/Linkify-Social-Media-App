import 'package:flutter/material.dart';
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
  bool isRecording = false;
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
                    child: isRecording
                        ? const Text("Recording...")
                        : TextFormField(
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
                textEditingController.text != "" || isRecording
                    ? const SizedBox()
                    : SendImageIcon(
                        toUser: widget.toUser,
                      ),
                textEditingController.text != ""
                    ? const SizedBox()
                    : IconButton(
                        onPressed: () {
                          setState(() {
                            isRecording = !isRecording;
                          });
                        },
                        icon: isRecording
                            ? const Icon(Icons.send, color: Colors.black)
                            : const Icon(Icons.mic, color: Colors.red),
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
