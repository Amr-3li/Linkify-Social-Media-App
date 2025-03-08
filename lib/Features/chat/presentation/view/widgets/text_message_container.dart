import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:linkify/Features/chat/data/model/message_model.dart';
import 'package:linkify/Features/chat/presentation/view/widgets/from_message.dart';
import 'package:linkify/Features/chat/presentation/view/widgets/to_message.dart';

class TextMessageContainer extends StatelessWidget {
  const TextMessageContainer({
    super.key,
    required this.message,
  });

  final MessageModel message;

  @override
  Widget build(BuildContext context) {
    final currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser == null) {
      return const SizedBox();
    }
    return currentUser.uid == message.fromId
        ? ToMessage(message: message)
        : FromMessage(message: message);
  }
}
