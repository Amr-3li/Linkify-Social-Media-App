import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:linkify/Features/friends/presentation/cubit/friends/friends_cubit.dart';
import 'package:linkify/Features/profile/presentation/cubit/get_user_status/get_user_status_cubit.dart';
import 'package:linkify/core/constants/colors.dart';
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
              title: "Remove Friend",
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
                            await BlocProvider.of<FriendsCubit>(context)
                                .removeFriend(userId);
                            await BlocProvider.of<GetUserStatusCubit>(context)
                                .userStatus(userId);
                          },
                          child: const Text("Remove")),
                      TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text("Cancel")),
                    ],
                    content: const Text("Are you sure you want to remove?"),
                  ),
                );
              }),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: CustomButton(
              title: "send message",
              color: MyColors.fromMessageBorder,
              onTap: () {
                GoRouter.of(context).push('/chatScrean/${userId}');
              }),
        )
      ]),
    );
  }
}
