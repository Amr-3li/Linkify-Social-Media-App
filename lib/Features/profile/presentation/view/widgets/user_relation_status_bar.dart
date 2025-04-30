import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:linkify/Features/profile/presentation/cubit/get_user_status/get_user_status_cubit.dart';
import 'package:linkify/Features/profile/presentation/view/widgets/friend_component.dart';
import 'package:linkify/Features/profile/presentation/view/widgets/friend_send_request_component.dart';
import 'package:linkify/Features/profile/presentation/view/widgets/my_profile_status_component.dart';
import 'package:linkify/Features/profile/presentation/view/widgets/no_relation_component.dart';
import 'package:linkify/Features/profile/presentation/view/widgets/you_send_request_component.dart';
import 'package:linkify/core/constants/constants.dart';

class UserRelationStatusBar extends StatelessWidget {
  const UserRelationStatusBar({
    super.key,
    required this.userId,
  });
  final String userId;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetUserStatusCubit, GetUserStatusState>(
      builder: (context, state) {
        return state is GetUserStatusLoadded
            ? Container(
                width: double.infinity,
                padding: const EdgeInsets.all(15),
                child: state.response == Constants.youSendRequest
                    ? const YouSendRequestComponent()
                    : state.response == Constants.friends
                        ? FriendComponent(userId: userId)
                        : state.response == Constants.friendSendRequest
                            ? const FriendSendRequestComponent()
                            : state.response == Constants.noRelation
                                ? NoRelationComponent(userId: userId)
                                : state.response == Constants.myAccount
                                    ? const MyProfileStatusComponent()
                                    : const SizedBox())
            : const SizedBox();
      },
    );
  }
}
