import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:linkify/Features/profile/presentation/cubit/update_user/update_user_cubit.dart';
import 'package:linkify/core/constants/colors.dart';

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
    return BlocConsumer<UpdateUserCubit, UpdateUserState>(
      listener: (context, state) {
        if (state is UpdateUserImageLoaded) {
          ScaffoldMessenger.of(context)
              .showSnackBar(const SnackBar(content: Text("Image updated")));
        } else if (state is UpdateUserImageError) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(state.message)));
        } else if (state is UpdateUserImageLoading) {
          ScaffoldMessenger.of(context)
              .showSnackBar(const SnackBar(content: Text("Loading...")));
        }
      },
      builder: (context, state) {
        return SliverAppBar(
          actions: [
            IconButton(
              onPressed: () async {
                await pickImage();
                context.read<UpdateUserCubit>().updateImage(imageFile!);
              },
              icon: const Icon(Icons.edit),
            ),
          ],
          backgroundColor: MyColors.appBarColor,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(30),
              bottomRight: Radius.circular(30),
            ),
          ),
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
                      bottomLeft: Radius.circular(50),
                      bottomRight: Radius.circular(50),
                    ),
                    image: DecorationImage(
                      image: NetworkImage(widget.image),
                      fit: BoxFit.cover,
                    )),
              ),
            ),
          ),
        );
      },
    );
  }

  Future<void> pickImage() async {
    XFile? ximage = await ImagePicker().pickImage(source: ImageSource.gallery);
    imageFile = File(ximage!.path);
    setState(() {});
  }
}
