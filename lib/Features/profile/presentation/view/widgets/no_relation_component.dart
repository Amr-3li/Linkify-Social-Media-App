import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:linkify/Features/friends/presentation/cubit/friends/friends_cubit.dart';
import 'package:linkify/Features/profile/presentation/cubit/get_user_status/get_user_status_cubit.dart';
import 'package:linkify/core/constants/colors.dart';
import 'package:linkify/core/constants/constants.dart';
import 'package:linkify/core/widgets/custom_button.dart';

class NoRelationComponent extends StatelessWidget {
  const NoRelationComponent({super.key, required this.userId});
  final String userId;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      width: double.infinity,
      height: 60,
      child: Row(children: [
        Expanded(
          child: CustomButton(
              title: Constants.addFriend,
              color: MyColors.iconActiveColor,
              onTap: () async {
                await BlocProvider.of<FriendsCubit>(context)
                    .sendFriendRequest(userId);
                await BlocProvider.of<GetUserStatusCubit>(context)
                    .userStatus(userId);
              }),
        ),
      ]),
    );
  }
}
