import 'package:flutter/material.dart';
import 'package:true_gym/core/constants/consts.dart';

class InputMessageContainerBody extends StatefulWidget {
  const InputMessageContainerBody({
    super.key,
  });

  @override
  State<InputMessageContainerBody> createState() =>
      _InputMessageContainerBodyState();
}

class _InputMessageContainerBodyState extends State<InputMessageContainerBody> {
  bool isTyping = false;
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
                const Expanded(
                  child: TextField(
                    // onTap: () {
                    //   setState(() {
                    //     isTyping = true;
                    //   });
                    // },
                    // onTapOutside: (event) {
                    //   setState(() {
                    //     isTyping = true;
                    //   });
                    // },

                    decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "  type a message",
                        hintStyle: TextStyle(
                            color: Color.fromARGB(255, 127, 127, 127))),
                  ),
                ),
                IconButton(onPressed: () {}, icon: const Icon(Icons.image)),
                IconButton(onPressed: () {}, icon: const Icon(Icons.camera_alt))
              ],
            ),
          ),
        ),
        IconButton(
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
