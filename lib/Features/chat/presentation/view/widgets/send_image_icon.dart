import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:true_gym/Features/chat/data/repository/chat_repo.dart';
import 'package:true_gym/Features/chat/presentation/cubit/send_message/send_message_cubit.dart';
import 'package:true_gym/Features/chat/presentation/view/pages/image_confirm_message.dart';
import 'package:true_gym/Features/register/data/model/user.dart';
import 'package:true_gym/Features/register/data/repository/image_repo.dart';
import 'package:true_gym/core/helper/pick_image.dart';
import 'package:true_gym/get_it.dart';

class SendImageIcon extends StatelessWidget {
  const SendImageIcon({super.key, required this.toUser});
  final UserModel toUser;

  @override
  Widget build(BuildContext context) {
    late File imageFile;
    return IconButton(
      onPressed: () async {
        await PickImage().pickImage((value) {
          imageFile = value;
        }).then((value) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => BlocProvider(
                create: (context) => SendMessageCubit(
                    gitItInstanse<ChatRepo>(), gitItInstanse<ImageRepo>()),
                child:
                    ImageConfirmMessage(toUser: toUser, imageFile: imageFile),
              ),
            ),
          );
        });
      },
      icon: const Icon(Icons.image),
    );
  }
}
