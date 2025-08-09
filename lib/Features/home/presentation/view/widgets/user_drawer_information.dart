import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:linkify/core/constants/colors.dart';
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
      decoration: const BoxDecoration(
        color: MyColors.primaryColor,
      ),
      accountName:
          Text(name.toString(), style: const TextStyle(color: Colors.black)),
      accountEmail:
          Text(email.toString(), style: const TextStyle(color: Colors.black)),
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
