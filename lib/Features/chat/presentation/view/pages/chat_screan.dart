import 'package:flutter/material.dart';
import 'package:true_gym/Features/chat/presentation/view/widgets/input_message_container.dart';
import 'package:true_gym/Features/chat/presentation/view/widgets/input_message_container_body.dart';
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
        body: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: 9,
                itemBuilder: (context, index) {
                  return TextMaessageContainer(
                    message: "hello",
                    time: DateTime.now(),
                  );
                },
              ),
            ),
            const InputMessageContainerBody(),
          ],
        ));
  }
}
