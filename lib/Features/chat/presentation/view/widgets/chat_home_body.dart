import 'package:flutter/material.dart';
import 'package:true_gym/core/consts.dart';

class ChatHomeBody extends StatelessWidget {
  const ChatHomeBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          leading: const CircleAvatar(
            radius: 20,
          ),
          title: const Text(
            "John Doe",
            style: TextStyle(color: MyColors.fontColor, fontSize: 15),
          ),
          subtitle: Text(
            "Hello, how are you doing?",
            style: TextStyle(
                color: MyColors.fontColor.withOpacity(0.5), fontSize: 12),
          ),
          trailing: const TrailingComponent(),
          onTap: () {},
        ),
      ],
    );
  }
}

class TrailingComponent extends StatelessWidget {
  const TrailingComponent({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const CircleAvatar(
          radius: 8,
          backgroundColor: Colors.green,
          child: Text(
            "2",
            style: TextStyle(fontSize: 10, color: Colors.white),
          ),
        ),
        Text(
          "10:30",
          style: TextStyle(
              color: MyColors.fontColor.withOpacity(0.5), fontSize: 12),
        ),
      ],
    );
  }
}
