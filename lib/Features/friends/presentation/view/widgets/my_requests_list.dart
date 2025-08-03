import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:linkify/Features/friends/data/repository/friends_repo.dart';
import 'package:linkify/Features/friends/presentation/cubit/friends/friends_cubit.dart';
import 'package:linkify/Features/friends/presentation/cubit/get_your_requests/get_your_requests_cubit.dart';
import 'package:linkify/Features/friends/presentation/view/widgets/my_request_item.dart';
import 'package:linkify/core/constants/animation.dart';
import 'package:linkify/core/constants/constants.dart';
import 'package:linkify/core/dependicy_injection/get_it.dart';
import 'package:lottie/lottie.dart';
import 'package:skeletonizer/skeletonizer.dart';

class MyRequestsList extends StatelessWidget {
  const MyRequestsList({
    super.key,
  });
  Future<void> _onRefresh(BuildContext context) async {
    await BlocProvider.of<GetYourRequestsCubit>(context).initialYourRequests();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        await _onRefresh(context);
      },
      child: BlocBuilder<GetYourRequestsCubit, GetYourRequestsState>(
        builder: (context, state) {
          if (state is GetYourRequestsLoading) {
            return Skeletonizer(
              child: ListView.builder(
                padding: const EdgeInsets.all(8),
                itemCount: 10,
                itemBuilder: (context, index) {
                  return const ListTile(
                      leading: CircleAvatar(radius: 20),
                      title: Text(Constants.skeltonizerTextSmall2));
                },
              ),
            );
          }
          if (state is GetYourRequestsLoaded && state.users.isNotEmpty) {
            return ListView.builder(
              padding: const EdgeInsets.all(8),
              itemCount: state.users.length,
              itemBuilder: (context, index) {
                return BlocProvider(
                  create: (context) =>
                      FriendsCubit(gitItInstanse<FriendsRepo>()),
                  child: MyRequestItem(user: state.users[index]),
                );
              },
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
                    onPressed: () async {
                      await _onRefresh(context);
                    },
                    child: const Text(Constants.tryAgain)),
                const Spacer()
              ],
            );
          }
        },
      ),
    );
  }
}
