import 'package:flutter/material.dart';
import 'package:linkify/core/constants/constants.dart';

class AddChatDialog extends StatelessWidget {
  const AddChatDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: const TextField(
          decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
        labelText: Constants.enterChatName,
      )),
      actions: [
        TextButton(onPressed: () {}, child: const Text(Constants.add)),
        TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text(Constants.cansel)),
      ],
    );
  }
}
