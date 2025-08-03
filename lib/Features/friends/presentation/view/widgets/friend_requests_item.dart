import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:linkify/Features/friends/presentation/cubit/friends/friends_cubit.dart';
import 'package:linkify/Features/friends/presentation/view/widgets/custom_ftiend_button.dart';
import 'package:linkify/core/constants/constants.dart';
import 'package:linkify/core/constants/images.dart';
import 'package:linkify/core/shared_logic/data/models/user.dart';

class FriendRequestsItem extends StatelessWidget {
  const FriendRequestsItem({super.key, required this.user});
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
            backgroundImage: user.image == ""
                ? const AssetImage(MyImages.imagesUserImage)
                : CachedNetworkImageProvider(user.image!),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: InkWell(
              onTap: () {
                GoRouter.of(context).push('/profilePage/${user.id}');
              },
              child: Text(
                user.name,
                style: const TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                    fontWeight: FontWeight.w500),
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
                return Row(
                  children: [
                    CustomFreindsButton(
                      title: Constants.reject,
                      color: const Color.fromARGB(149, 151, 0, 0),
                      onTap: () async {
                        await context
                            .read<FriendsCubit>()
                            .rejectFriendRequest(user.id!);
                      },
                    ),
                    const SizedBox(width: 10),
                    CustomFreindsButton(
                      title: Constants.accept,
                      color: const Color.fromARGB(255, 68, 126, 121),
                      onTap: () async {
                        await context
                            .read<FriendsCubit>()
                            .acceptFriendRequest(user.id!);
                      },
                    ),
                  ],
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
