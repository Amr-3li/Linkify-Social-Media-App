import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:linkify/Features/chat/presentation/view/pages/chat_page.dart';
import 'package:linkify/Features/friends/presentation/cubit/friends/friends_cubit.dart';
import 'package:linkify/Features/profile/presentation/cubit/get_user_status/get_user_status_cubit.dart';
import 'package:linkify/core/constants/colors.dart';
import 'package:linkify/core/constants/constants.dart';
import 'package:linkify/core/widgets/custom_button.dart';

class FriendComponent extends StatelessWidget {
  const FriendComponent({super.key, required this.userId});
  final String userId;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 40,
      child: Row(children: [
        Expanded(
          flex: 1,
          child: CustomButton(
              title: Constants.removeFriend,
              color: const Color.fromARGB(149, 151, 0, 0),
              onTap: () {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    backgroundColor: Colors.white,
                    contentPadding: const EdgeInsets.all(10),
                    actions: [
                      TextButton(
                          onPressed: () async {
                            await context
                                .read<FriendsCubit>()
                                .removeFriend(userId);
                            await BlocProvider.of<GetUserStatusCubit>(context)
                                .userStatus(userId);
                          },
                          child: const Text(Constants.remove)),
                      TextButton(
                          onPressed: () {
                            GoRouter.of(context).pop();
                          },
                          child: const Text(Constants.cansel)),
                    ],
                    content: const Text(Constants.areYouSure),
                  ),
                );
              }),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: CustomButton(
              title: Constants.sendMessage,
              color: MyColors.fromMessageBorder,
              onTap: () {
                GoRouter.of(context).push('${ChatPage.routeName}/$userId');
              }),
        )
      ]),
    );
  }
}
