import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:linkify/Features/friends/data/repository/get_friends_or_requests_repo.dart';
import 'package:linkify/Features/friends/presentation/cubit/get_friends/get_friends_cubit.dart';
import 'package:linkify/Features/friends/presentation/cubit/get_friends_requests/get_friends_requests_cubit.dart';
import 'package:linkify/Features/friends/presentation/cubit/get_your_requests/get_your_requests_cubit.dart';
import 'package:linkify/Features/friends/presentation/view/widgets/friend_requests_list.dart';
import 'package:linkify/Features/friends/presentation/view/widgets/my_friend_list.dart';
import 'package:linkify/Features/friends/presentation/view/widgets/my_requests_list.dart';
import 'package:linkify/core/constants/constants.dart';
import 'package:linkify/core/dependicy_injection/get_it.dart';

class FriendPage extends StatefulWidget {
  const FriendPage({super.key});

  @override
  State<FriendPage> createState() => _FriendPageState();
}

class _FriendPageState extends State<FriendPage> {
  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: const SizedBox(),
          centerTitle: true,
          title: const Text("Friends",
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        ),
        body: Column(children: [
          Container(
              padding: const EdgeInsets.all(10),
              width: double.infinity,
              color: Theme.of(context).colorScheme.surface,
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    tapNavigateItem(0, Constants.myFriends),
                    tapNavigateItem(1, Constants.friendsRequests),
                    tapNavigateItem(2, Constants.myRequests),
                  ])),
          Expanded(
              child: IndexedStack(
            index: currentIndex,
            children: [
              BlocProvider(
                create: (context) =>
                    GetFriendsCubit(gitItInstanse<GetFriendsOrRequestsRepo>())
                      ..getUserFrinds(),
                child: const MyFriendList(),
              ),
              BlocProvider(
                create: (context) => GetFriendsRequestsCubit(
                    gitItInstanse<GetFriendsOrRequestsRepo>())
                  ..getFriendRequests(),
                child: const FriendsRequestsList(),
              ),
              BlocProvider(
                create: (context) => GetYourRequestsCubit(
                    gitItInstanse<GetFriendsOrRequestsRepo>())
                  ..getYourRequests(),
                child: const MyRequestsList(),
              ),
            ],
          ))
        ]));
  }

  GestureDetector tapNavigateItem(int index, String title) {
    return GestureDetector(
      onTap: () {
        setState(() {
          currentIndex = index;
        });
      },
      child: Column(
        children: [
          Text(title,
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.secondary)),
          currentIndex == index
              ? Container(
                  margin: const EdgeInsets.only(top: 7),
                  width: 70,
                  height: 2.5,
                  color: Theme.of(context).colorScheme.inverseSurface)
              : const SizedBox(),
        ],
      ),
    );
  }
}
