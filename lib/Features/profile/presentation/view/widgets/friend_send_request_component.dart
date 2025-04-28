import 'package:flutter/material.dart';
import 'package:linkify/core/widgets/custom_button.dart';

class FriendSendRequestComponent extends StatelessWidget {
  const FriendSendRequestComponent({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      Expanded(
          child:
              CustomButton(title: "reject", color: Colors.red, onTap: () {})),
      const SizedBox(width: 10),
      Expanded(
          child:
              CustomButton(title: "Accept", color: Colors.green, onTap: () {})),
    ]);
  }
}
