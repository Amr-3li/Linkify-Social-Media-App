import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:true_gym/Features/chat/data/model/message_model.dart';
import 'package:true_gym/core/constants/colors.dart';
import 'package:true_gym/core/helper/time.dart';

class TextMessageContainer extends StatelessWidget {
  const TextMessageContainer({
    super.key,
    required this.message,
  });

  final MessageModel message;

  @override
  Widget build(BuildContext context) {
    final currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser == null)
      return const SizedBox(); // تجنب الأخطاء في حالة عدم تسجيل الدخول
    return currentUser.uid == message.fromId
        ? _toMessage(context)
        : _fromMessage(context);
  }

  Widget _fromMessage(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Flexible(
          child: Container(
            padding: const EdgeInsets.all(10),
            margin: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: MyColors.fromMessage,
              border: Border.all(color: MyColors.fromMessageBorder, width: 2),
              borderRadius: const BorderRadius.only(
                  bottomRight: Radius.circular(20),
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                message.imageUrl != ""
                    ? InkWell(
                        onTap:
                            () {}, // يمكنك إضافة وظيفة هنا عند الضغط على الصورة
                        child: CachedNetworkImage(
                          imageUrl: message.imageUrl!,
                          placeholder: (context, url) =>
                              const CircularProgressIndicator(),
                          errorWidget: (context, url, error) =>
                              const Icon(Icons.error),
                          fit: BoxFit.cover,
                        ),
                      )
                    : Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 2.0, vertical: 3),
                        child: Text(
                          message.msg ?? "",
                          style: const TextStyle(
                              color: Colors.black, fontSize: 16),
                        ),
                      ),
              ],
            ),
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

  Widget _toMessage(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          MyTime.getFormattedTime(context, time: message.time),
          style: const TextStyle(color: MyColors.time, fontSize: 13),
        ),
        Flexible(
          child: Container(
            padding: const EdgeInsets.all(10),
            margin: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: MyColors.toMessage,
              border: Border.all(color: MyColors.toMessageBorder, width: 2),
              borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                message.imageUrl != ""
                    ? InkWell(
                        onTap: () {}, // إضافة حدث عند الضغط على الصورة
                        child: CachedNetworkImage(
                          imageUrl: message.imageUrl!,
                          placeholder: (context, url) =>
                              const CircularProgressIndicator(),
                          errorWidget: (context, url, error) =>
                              const Icon(Icons.error),
                          fit: BoxFit.cover,
                        ),
                      )
                    : Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 5.0, vertical: 3),
                        child: Text(
                          message.msg ?? "",
                          style: const TextStyle(
                              color: Color(0xff333333), fontSize: 16),
                        ),
                      ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
