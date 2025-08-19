import 'dart:io';

import 'package:flutter/material.dart';
import 'package:linkify/Features/chat/presentation/view/pages/image_confirm_message.dart';
import 'package:linkify/core/exports/app_router.dart';
import 'package:linkify/core/helper/pick_image.dart';

class SendImageIcon extends StatelessWidget {
  const SendImageIcon({super.key, required this.toUserId});
  final String toUserId;

  @override
  Widget build(BuildContext context) {
    late File imageFile;
    return IconButton(
      onPressed: () async {
        imageFile = await PickImage().pickImage();
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => BlocProvider(
              create: (context) => SendMessageCubit(
                  gitItInstanse<ChatRepo>(), gitItInstanse<ImageRepo>()),
              child:
                  ImageConfirmMessage(toUserId: toUserId, imageFile: imageFile),
            ),
          ),
        );
      },
      icon: const Icon(Icons.image),
    );
  }
}
