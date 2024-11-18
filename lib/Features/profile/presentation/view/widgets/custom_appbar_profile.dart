import 'package:flutter/material.dart';
import 'package:true_gym/core/consts.dart';

class CustomAppbarProfile extends StatelessWidget {
  const CustomAppbarProfile({
    super.key,
    required this.name,
    required this.image,
  });
  final String name, image;

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      backgroundColor: MyColors.appBarColor,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(20),
          bottomRight: Radius.circular(20),
        ),
      ),
      floating: true,
      pinned: true,
      expandedHeight: 280,
      flexibleSpace: FlexibleSpaceBar(
        titlePadding: const EdgeInsets.only(bottom: 10),
        title: Text(name),
        centerTitle: true,
        background: Hero(
          tag: "profile-page",
          child: Container(
            decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                ),
                image: DecorationImage(
                  image: NetworkImage(image),
                  fit: BoxFit.cover,
                )),
          ),
        ),
      ),
    );
  }
}
