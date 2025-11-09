import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:linkify/Features/profile/presentation/cubit/get_user_status/get_user_status_cubit.dart';
import 'package:linkify/Features/profile/presentation/view/widgets/friend_component.dart';
import 'package:linkify/Features/profile/presentation/view/widgets/friend_send_request_component.dart';
import 'package:linkify/Features/profile/presentation/view/widgets/my_profile_status_component.dart';
import 'package:linkify/Features/profile/presentation/view/widgets/no_relation_component.dart';
import 'package:linkify/Features/profile/presentation/view/widgets/you_send_request_component.dart';

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
                padding: const EdgeInsets.only(
                    bottom: 20, top: 5, left: 15, right: 15),
                child: state.response == "YouSendRequest"
                    ? YouSendRequestComponent(userId: userId)
                    : state.response == "Friends"
                        ? FriendComponent(userId: userId)
                        : state.response == "FriendSendRequest"
                            ? const FriendSendRequestComponent()
                            : state.response == "NoRelation"
                                ? NoRelationComponent(userId: userId)
                                : state.response == "MyAccount"
                                    ? const MyProfileStatusComponent()
                                    : const SizedBox())
            : const SizedBox();
      },
    );
  }
}
