import 'package:flutter/material.dart';
import 'package:true_gym/Features/chat/data/model/message_model.dart';
import 'package:true_gym/Features/chat/presentation/view/widgets/input_message_container.dart';
import 'package:true_gym/Features/chat/presentation/view/widgets/text_message_container.dart';
import 'package:true_gym/core/constants/consts.dart';

class ChatScrean extends StatelessWidget {
  const ChatScrean({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: MyColors.appBarColor,
          centerTitle: true,
          title: const Text("the friend name"),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: 9,
                  itemBuilder: (context, index) {
                    return TextMaessageContainer(
                      message: MessageModel(
                          msg: "asdasd",
                          fromId: "adas",
                          toId: "asdasd",
                          lastMessage: "asdasdasd",
                          time: "asdas",
                          unreadCount: 5),
                    );
                  },
                ),
              ),
              const InputMessageContainer(),
            ],
          ),
        ));
  }
}
