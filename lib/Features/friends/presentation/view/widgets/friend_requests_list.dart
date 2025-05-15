import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:linkify/Features/friends/data/repository/friends_repo.dart';
import 'package:linkify/Features/friends/presentation/cubit/friends/friends_cubit.dart';
import 'package:linkify/Features/friends/presentation/cubit/get_friends_requests/get_friends_requests_cubit.dart';
import 'package:linkify/Features/friends/presentation/view/widgets/friend_requests_item.dart';
import 'package:linkify/core/constants/animation.dart';
import 'package:linkify/core/dependicy_injection/get_it.dart';
import 'package:lottie/lottie.dart';
import 'package:skeletonizer/skeletonizer.dart';

class FriendsRequestsList extends StatelessWidget {
  const FriendsRequestsList({
    super.key,
  });
  Future<void> _onRefresh(BuildContext context) async {
    await BlocProvider.of<GetFriendsRequestsCubit>(context)
        .initialFriendRequests();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetFriendsRequestsCubit, GetFriendsRequestsState>(
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
          return RefreshIndicator(
            onRefresh: () async {
              await _onRefresh(context);
            },
            child: ListView.builder(
              padding: const EdgeInsets.all(8),
              itemCount: state.users.length,
              itemBuilder: (context, index) {
                return BlocProvider(
                  create: (context) =>
                      FriendsCubit(gitItInstanse<FriendsRepo>()),
                  child: FriendRequestsItem(user: state.users[index]),
                );
              },
            ),
          );
        } else {
          return Column(
            children: [
              const Spacer(),
              LottieBuilder.asset(MyAnimation.animationsNotExist),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    foregroundColor: Colors.white,
                  ),
                  onPressed: () => _onRefresh(context),
                  child: const Text("try again")),
              const Spacer(),
            ],
          );
        }
      },
    );
  }
}
