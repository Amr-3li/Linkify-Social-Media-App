import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:linkify/core/constants/constants.dart';
import 'package:linkify/core/shared_logic/data/models/user.dart';

class UserItem extends StatelessWidget {
  const UserItem({
    super.key,
    required this.user,
  });
  final UserModel user;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        GoRouter.of(context).push('/profilePage/${user.id}');
      },
      leading: CircleAvatar(
          radius: 20,
          backgroundImage: CachedNetworkImageProvider(
              user.image == "" ? Constants.defaultUserImage : user.image!)),
      title: Text(user.name),
      subtitle: Text(user.email),
    );
  }
}
