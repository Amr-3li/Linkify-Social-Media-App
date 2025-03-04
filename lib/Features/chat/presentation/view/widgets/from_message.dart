import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:true_gym/Features/chat/data/model/message_model.dart';
import 'package:true_gym/Features/chat/presentation/view/pages/image_presentation_page.dart';
import 'package:true_gym/core/constants/colors.dart';
import 'package:true_gym/core/helper/audio.dart';
import 'package:true_gym/core/helper/time.dart';
import 'package:voice_message_package/voice_message_package.dart';

class FromMessage extends StatelessWidget {
  const FromMessage({
    super.key,
    required this.message,
  });

  final MessageModel message;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Flexible(
          child: message.recordUrl == null || message.recordUrl!.isEmpty
              ? Container(
                  padding: const EdgeInsets.all(10),
                  margin: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: MyColors.fromMessage,
                    border:
                        Border.all(color: MyColors.fromMessageBorder, width: 2),
                    borderRadius: const BorderRadius.only(
                        bottomRight: Radius.circular(20),
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
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
                            placeholder: (context, url) => const Center(
                                child: CircularProgressIndicator()),
                            errorWidget: (context, url, error) =>
                                const Icon(Icons.error, color: Colors.red),
                            fit: BoxFit.cover,
                          ),
                        ),
                      if (message.msg != null && message.msg!.isNotEmpty)
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 2.0, vertical: 3),
                          child: Text(
                            message.msg!,
                            style: const TextStyle(
                                color: Colors.black, fontSize: 16),
                          ),
                        ),
                    ],
                  ),
                )
              : VoiceMessageView(
                  backgroundColor: MyColors.fromMessage,
                  controller: VoiceController(
                    audioSrc: message.recordUrl!,
                    maxDuration: const Duration(minutes: 10),
                    isFile: false,
                    onComplete: () {
                      Audio().stopPlayback();
                    },
                    onPause: () {
                      Audio().stopPlayback();
                    },
                    onPlaying: () async {},
                    onError: (err) {
                      // Handle any errors during audio playback
                      debugPrint('Audio playback error: $err');
                    },
                  ),
                  circlesColor: const Color.fromARGB(194, 0, 66, 66),
                  innerPadding: 12,
                  cornerRadius: 20,
                ),
        ),
        Padding(
          padding: const EdgeInsets.only(right: 8),
          child: Text(
            MyTime.getFormattedTime(context, time: message.time),
            style: const TextStyle(color: Colors.blueGrey, fontSize: 13),
          ),
        ),
      ],
    );
  }
}
