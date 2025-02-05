import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:true_gym/Features/chat/data/model/message_model.dart';
import 'package:true_gym/core/constants/colors.dart';

class TextMaessageContainer extends StatelessWidget {
  const TextMaessageContainer({
    super.key,
    required this.message,
  });
  final MessageModel message;

  @override
  Widget build(BuildContext context) {
    // ignore: unrelated_type_equality_checks
    return FirebaseAuth.instance.currentUser == message.fromId
        ? _fromMessage()
        : _toMessage();
  }

  Widget _fromMessage() {
    return Row(
      children: [
        Flexible(
          child: Container(
              padding: const EdgeInsets.all(10),
              margin: const EdgeInsets.all(8),
              decoration: const BoxDecoration(
                  color: MyColors.fromMessage,
                  borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(15),
                    topLeft: Radius.circular(15),
                    topRight: Radius.circular(15),
                  )),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  message.imageUrl != ""
                      ? InkWell(
                          onTap: () {},
                          child: CachedNetworkImage(
                            imageUrl:
                                'https://www.pngitem.com/pimgs/m/150-1503945_transparent-user-png-default-user-image-png-png.png',
                            filterQuality: FilterQuality.high,
                          ),
                        )
                      : Text(
                          message.msg!,
                          style: const TextStyle(
                              color: Colors.black87, fontSize: 15),
                        ),
                  Align(
                      alignment: AlignmentDirectional.bottomEnd,
                      child: Text(
                        message.time,
                        style: const TextStyle(color: Colors.blueGrey),
                      ))
                ],
              )),
        ),
        const SizedBox(width: 40)
      ],
    );
  }

  Widget _toMessage() {
    return Row(
      children: [
        const SizedBox(width: 40),
        Flexible(
          child: Container(
              padding: const EdgeInsets.all(10),
              margin: const EdgeInsets.all(8),
              decoration: const BoxDecoration(
                  color: MyColors.toMessage,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(15),
                    topLeft: Radius.circular(15),
                    topRight: Radius.circular(15),
                  )),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  message.imageUrl != ""
                      ? InkWell(
                          onTap: () {},
                          child: CachedNetworkImage(
                            imageUrl:
                                'https://www.pngitem.com/pimgs/m/150-1503945_transparent-user-png-default-user-image-png-png.png',
                            filterQuality: FilterQuality.high,
                          ),
                        )
                      : Text(
                          message.msg!,
                          style: const TextStyle(
                              color: Colors.white, fontSize: 15),
                        ),
                  Align(
                      alignment: AlignmentDirectional.bottomEnd,
                      child: Text(
                        message.time,
                        style: const TextStyle(color: MyColors.time),
                      ))
                ],
              )),
        ),
      ],
    );
  }
}
