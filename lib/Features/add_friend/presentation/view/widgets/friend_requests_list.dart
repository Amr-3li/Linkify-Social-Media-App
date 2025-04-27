import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:linkify/Features/add_friend/presentation/cubit/get_friends_requests/get_friends_requests_cubit.dart';
import 'package:linkify/Features/add_friend/presentation/view/widgets/friend_requests_item.dart';
import 'package:linkify/core/constants/animation.dart';
import 'package:lottie/lottie.dart';
import 'package:skeletonizer/skeletonizer.dart';

class FriendsRequestsList extends StatelessWidget {
  const FriendsRequestsList({
    super.key,
  });
  Future<void> _onRefresh() async {
    // هنا تحط لوجيك الريفرش اللي انت عايزه
    await Future.delayed(const Duration(seconds: 1));
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      displacement: 20,
      color: Colors.green,
      backgroundColor: Colors.white,
      strokeWidth: 2,
      onRefresh: _onRefresh,
      child: BlocBuilder<GetFriendsRequestsCubit, GetFriendsRequestsState>(
        builder: (context, state) {
          if (state is GetFriendsRequestsLoading) {
            return Skeletonizer(
              child: ListView.builder(
                padding: const EdgeInsets.all(8),
                itemCount: 10,
                itemBuilder: (context, index) {
                  return const ListTile(
                      leading: CircleAvatar(radius: 20),
                      title: Text(" asf asdf asdf "));
                },
              ),
            );
          }
          if (state is GetFriendsRequestsLoaded && state.users.isNotEmpty) {
            return ListView.builder(
              padding: const EdgeInsets.all(8),
              itemCount: state.users.length,
              itemBuilder: (context, index) {
                return FriendRequestsItem(
                  user: state.users[index],
                );
              },
            );
          } else {
            return Center(
              child: LottieBuilder.asset(MyAnimation.animationsNotExist),
            );
          }
        },
      ),
    );
  }
}
