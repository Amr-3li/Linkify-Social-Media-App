
import 'package:flutter/material.dart';

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

            labelText: 'Enter chat name',
          )),
      actions: [
        TextButton(onPressed: () {}, child: const Text("Add")),
        TextButton(onPressed: () {
          Navigator.pop(context);
        }, child: const Text("Cancel")),
      ],
    );
  }
}