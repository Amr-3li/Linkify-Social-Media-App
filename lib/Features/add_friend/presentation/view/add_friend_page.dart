import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:linkify/Features/add_friend/data/repository/friends_repo.dart';
import 'package:linkify/Features/add_friend/data/repository/get_friends_or_requests_repo.dart';
import 'package:linkify/Features/add_friend/presentation/cubit/friends/friends_cubit.dart';
import 'package:linkify/Features/add_friend/presentation/cubit/get_friends/get_friends_cubit.dart';
import 'package:linkify/Features/add_friend/presentation/cubit/get_friends_requests/get_friends_requests_cubit.dart';
import 'package:linkify/Features/add_friend/presentation/cubit/get_your_requests/get_your_requests_cubit.dart';
import 'package:linkify/Features/add_friend/presentation/view/widgets/friend_requests_list.dart';
import 'package:linkify/Features/add_friend/presentation/view/widgets/my_friend_list.dart';
import 'package:linkify/Features/add_friend/presentation/view/widgets/my_requests_list.dart';
import 'package:linkify/core/constants/colors.dart';
import 'package:linkify/core/dependicy_injection/get_it.dart';

class AddFriendPage extends StatefulWidget {
  const AddFriendPage({super.key});

  @override
  State<AddFriendPage> createState() => _AddFriendPageState();
}

class _AddFriendPageState extends State<AddFriendPage> {
  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: MyColors.appBarColor,
          leading: const SizedBox(),
          centerTitle: true,
          title: const Text("Friends",
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        ),
        backgroundColor: MyColors.backgroundColor,
        body: Column(children: [
          Container(
              padding: const EdgeInsets.all(10),
              width: double.infinity,
              color: MyColors.backgroundColor,
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    tapNavigateItem(0, "My Friends"),
                    tapNavigateItem(1, "Friend requests"),
                    tapNavigateItem(2, "My requests")
                  ])),
          BlocProvider(
            create: (context) => FriendsCubit(gitItInstanse<FriendsRepo>()),
            child: Expanded(
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
            )),
          )
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
              style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: MyColors.iconActiveColor)),
          currentIndex == index
              ? Container(
                  margin: const EdgeInsets.only(top: 7),
                  width: 70,
                  height: 2.5,
                  color: Colors.black)
              : const SizedBox(),
        ],
      ),
    );
  }
}
