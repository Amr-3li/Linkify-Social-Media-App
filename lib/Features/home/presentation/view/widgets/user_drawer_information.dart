import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:linkify/core/constants/images.dart';

class UserDrawerInformation extends StatelessWidget {
  const UserDrawerInformation(
      {super.key,
      required this.name,
      required this.email,
      required this.image});
  final String name, email, image;
  @override
  Widget build(BuildContext context) {
    return UserAccountsDrawerHeader(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primary,
      ),
      accountName: Text(name.toString(),
          style: TextStyle(color: Theme.of(context).colorScheme.onSurface)),
      accountEmail: Text(email.toString(),
          style: TextStyle(color: Theme.of(context).colorScheme.onSurface)),
      currentAccountPicture: Hero(
        transitionOnUserGestures: true,
        tag: 'profile-tag',
        child: CircleAvatar(
          backgroundImage: image == ""
              ? const AssetImage(MyImages.imagesUserImage)
              : CachedNetworkImageProvider(image),
        ),
      ),
    );
  }
}
