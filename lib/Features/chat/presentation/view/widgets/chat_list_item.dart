import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:linkify/Features/chat/data/repository/chat_repo.dart';
import 'package:linkify/Features/chat/presentation/cubit/get_messages/chat_cubit.dart';
import 'package:linkify/Features/chat/presentation/cubit/send_message/send_message_cubit.dart';
import 'package:linkify/Features/chat/presentation/view/pages/chat_page.dart';
import 'package:linkify/Features/chat/presentation/view/widgets/chat_item_trailng_component.dart';
import 'package:linkify/Features/register/data/model/user.dart';
import 'package:linkify/Features/register/data/repository/image_repo.dart';
import 'package:linkify/core/constants/colors.dart';
import 'package:linkify/core/constants/constants.dart';
import 'package:linkify/get_it.dart';

class ChatListItem extends StatelessWidget {
  const ChatListItem({
    super.key,
    required this.toUser,
  });
  final UserModel toUser;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        radius: 22,
        backgroundImage: toUser.image == ""
            ? CachedNetworkImageProvider(Constants.defaultUserImage)
            : CachedNetworkImageProvider(toUser.image!),
      ),
      title: Text(
        toUser.fname,
        style: const TextStyle(color: MyColors.fontColor, fontSize: 15),
      ),
      trailing: const ChatItemTrailingComponent(
        time: "dasdasd",
      ),
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return MultiBlocProvider(providers: [
            BlocProvider(
              create: (context) => ChatCubit(gitItInstanse<ChatRepo>()),
            ),
            BlocProvider(
              create: (context) => SendMessageCubit(
                  gitItInstanse<ChatRepo>(), gitItInstanse<ImageRepo>()),
            )
          ], child: ChatPage(toUser: toUser));
        }));
      },
    );
  }
}
