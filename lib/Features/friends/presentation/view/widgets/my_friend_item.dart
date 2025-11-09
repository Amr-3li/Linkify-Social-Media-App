import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:linkify/Features/friends/presentation/cubit/friends/friends_cubit.dart';
import 'package:linkify/Features/profile/presentation/view/profile.dart';
import 'package:linkify/core/constants/constants.dart';
import 'package:linkify/core/constants/images.dart';
import 'package:linkify/core/shared_logic/data/models/user.dart';

class MyFriendItem extends StatelessWidget {
  const MyFriendItem({super.key, required this.user});
  final UserModel user;

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6),
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: theme.colorScheme.shadow,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 25,
            backgroundImage: user.image == ""
                ? const AssetImage(MyImages.imagesUserImage)
                : CachedNetworkImageProvider(user.image!),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: InkWell(
              onTap: () {
                GoRouter.of(context)
                    .push('${ProfilePage.routeName}/${user.id}');
              },
              child: Text(
                user.name,
                style: TextStyle(
                  fontSize: 16,
                  color: theme.colorScheme.onSurface,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
          BlocBuilder<FriendsCubit, FriendsState>(
            builder: (context, state) {
              if (state is FriendsLoading) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is FriendsLoaded) {
                return const SizedBox();
              } else {
                return PopupMenuButton<String>(
                    onSelected: (value) async {
                      if (value == "UnFriend") {
                        await BlocProvider.of<FriendsCubit>(context)
                            .removeFriend(user.id!);
                      }
                    },
                    itemBuilder: (context) => [
                          PopupMenuItem<String>(
                              value: "UnFriend",
                              child: Text(Constants.unFriend.tr())),
                        ],
                    icon: const Icon(Icons.more_vert));
              }
            },
          ),
        ],
      ),
    );
  }
}
