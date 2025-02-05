// import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:true_gym/core/constants/colors.dart';

class InputMessageContainer extends StatefulWidget {
  const InputMessageContainer({
    super.key,
  });

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
                    maxLines: 10,
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
                onPressed: () {},
                icon: const Icon(
                  Icons.send,
                  color: Colors.blue,
                  size: 30,
                ))
      ],
    );
  }
}
