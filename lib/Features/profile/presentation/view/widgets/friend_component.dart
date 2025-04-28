import 'package:flutter/material.dart';
import 'package:linkify/core/widgets/custom_button.dart';

class FriendComponent extends StatelessWidget {
  const FriendComponent({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      const Spacer(flex: 1),
      Expanded(
          flex: 2,
          child: CustomButton(
              title: "Remove Friend", color: Colors.red, onTap: () {})),
      const Spacer(flex: 1)
    ]);
  }
}
