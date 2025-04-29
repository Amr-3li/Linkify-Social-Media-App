import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:linkify/Features/add_friend/presentation/cubit/friends/friends_cubit.dart';
import 'package:linkify/Features/add_friend/presentation/cubit/get_friends/get_friends_cubit.dart';
import 'package:linkify/core/constants/constants.dart';
import 'package:linkify/core/shared_logic/data/models/user.dart';

class MyFriendItem extends StatelessWidget {
  const MyFriendItem({super.key, required this.user});
  final UserModel user;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6),
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 25,
            backgroundImage: CachedNetworkImageProvider(
              user.image == "" ? Constants.defaultUserImage : user.image!,
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              user.name,
              style: const TextStyle(
                fontSize: 17,
                color: Colors.black,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          BlocBuilder<FriendsCubit, FriendsState>(
            builder: (context, state) {
              return state is FriendsLoading
                  ? const CircularProgressIndicator()
                  : PopupMenuButton<String>(
                      onSelected: (value) async {
                        if (value == 'unfriend') {
                          await BlocProvider.of<FriendsCubit>(context)
                              .removeFriend(user.id!);
                          await BlocProvider.of<GetFriendsCubit>(context)
                              .getUserFrinds();
                        }
                      },
                      itemBuilder: (context) => [
                            const PopupMenuItem<String>(
                                value: 'unfriend', child: Text("Unfriend")),
                          ],
                      icon: const Icon(Icons.more_vert));
            },
          ),
        ],
      ),
    );
  }
}
