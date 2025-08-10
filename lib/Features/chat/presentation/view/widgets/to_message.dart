import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:linkify/Features/chat/data/model/message_model.dart';
import 'package:linkify/Features/chat/presentation/view/pages/image_presentation_page.dart';
import 'package:linkify/core/constants/colors.dart';
import 'package:linkify/core/helper/time.dart';
import 'package:voice_message_package/voice_message_package.dart';

class ToMessage extends StatelessWidget {
  const ToMessage({
    super.key,
    required this.message,
  });

  final MessageModel message;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          MyTime.getFormattedTime(context, time: message.time),
          style: const TextStyle(color: MyColors.time, fontSize: 13),
        ),
        Flexible(
          child: message.recordUrl == null || message.recordUrl!.isEmpty
              ? Container(
                  padding: const EdgeInsets.all(10),
                  margin: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.onTertiaryContainer,
                    border:
                        Border.all(color: MyColors.toMessageBorder, width: 2),
                    borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(20),
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      if (message.imageUrl != null &&
                          message.imageUrl!.isNotEmpty)
                        InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => ImagePresentationPage(
                                    image: message.imageUrl!),
                              ),
                            );
                          },
                          child: CachedNetworkImage(
                            imageUrl: message.imageUrl!,
                            placeholder: (context, url) =>
                                const CircularProgressIndicator(),
                            errorWidget: (context, url, error) =>
                                const Icon(Icons.error),
                            fit: BoxFit.cover,
                          ),
                        ),
                      if (message.msg != null && message.msg!.isNotEmpty)
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 5.0, vertical: 3),
                          child: Text(
                            message.msg!,
                            style: TextStyle(
                                color: Theme.of(context).colorScheme.onSurface,
                                fontSize: 16),
                          ),
                        ),
                    ],
                  ),
                )
              : Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: VoiceMessageView(
                    backgroundColor:
                        Theme.of(context).colorScheme.onTertiaryContainer,
                    controller: VoiceController(
                      audioSrc: message.recordUrl!,
                      maxDuration: const Duration(minutes: 10),
                      isFile: false,
                      onComplete: () async {},
                      onPause: () async {},
                      onPlaying: () async {},
                      onError: (err) {
                        log(err.toString());
                      },
                    ),
                    circlesColor:
                        Theme.of(context).colorScheme.onTertiaryContainer,
                    innerPadding: 8,
                    cornerRadius: 30,
                  ),
                ),
        )
      ],
    );
  }
}
