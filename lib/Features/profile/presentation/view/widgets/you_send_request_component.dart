import 'package:flutter/material.dart';

class YouSendRequestComponent extends StatelessWidget {
  const YouSendRequestComponent({super.key});

  @override
  Widget build(BuildContext context) {
    return const Row(children: [
      Spacer(flex: 1),
      Expanded(
        flex: 2,
        child: Text("UnSend request"),
      ),
      Spacer(flex: 1)
    ]);
  }
}
