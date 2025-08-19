import 'package:flutter/material.dart';
import 'package:linkify/core/constants/colors.dart';
import 'package:linkify/core/constants/constants.dart';
import 'package:linkify/core/exports/app_router.dart';
import 'package:linkify/core/widgets/custom_button.dart';

class YouSendRequestComponent extends StatelessWidget {
  const YouSendRequestComponent({super.key, required this.userId});
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
              title: Constants.canselRequest,
              color: MyColors.fromMessageBorder,
              onTap: () async {
                await BlocProvider.of<FriendsCubit>(context)
                    .unSendFriendRequest(userId);
                await BlocProvider.of<GetUserStatusCubit>(context)
                    .userStatus(userId);
              }),
        ),
      ]),
    );
  }
}
