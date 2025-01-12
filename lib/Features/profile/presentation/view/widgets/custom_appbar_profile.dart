import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:true_gym/core/utils/consts.dart';

class CustomAppbarProfile extends StatefulWidget {
  const CustomAppbarProfile({
    super.key,
    required this.name,
    required this.image,
  });
  final String name, image;

  @override
  State<CustomAppbarProfile> createState() => _CustomAppbarProfileState();
}

class _CustomAppbarProfileState extends State<CustomAppbarProfile> {
  File? imageFile;
  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      actions: [
        IconButton(
          onPressed: () {
            pickImage();
          },
          icon: const Icon(Icons.edit),
        ),
      ],
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
        title: Text(widget.name),
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
                  image: NetworkImage(widget.image),
                  fit: BoxFit.cover,
                )),
          ),
        ),
      ),
    );
  }

  Future<void> pickImage() async {
    XFile? ximage = await ImagePicker().pickImage(source: ImageSource.gallery);
    imageFile = File(ximage!.path);
    setState(() {});
  }
}
