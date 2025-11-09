import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:linkify/Features/profile/presentation/cubit/update_user/update_user_cubit.dart';
import 'package:linkify/core/constants/colors.dart';
import 'package:linkify/core/constants/constants.dart';
import 'package:linkify/core/constants/images.dart';

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
          ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(Constants.imageUpdated.tr())));
        } else if (state is UpdateUserImageError) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(state.message)));
        } else if (state is UpdateUserImageLoading) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(Constants.loading.tr())));
        }
      },
      builder: (context, state) {
        return SliverAppBar(
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back,
              color: MyColors.light,
            ),
            onPressed: () => Navigator.pop(context),
          ),
          actions: [
            IconButton(
              onPressed: () async {
                await pickImage();
                context.read<UpdateUserCubit>().updateImage(imageFile!);
              },
              icon: const Icon(Icons.edit),
            ),
          ],
          backgroundColor: Theme.of(context).colorScheme.surface,
          expandedHeight: 200,
          flexibleSpace: FlexibleSpaceBar(
            background: Hero(
              tag: "profile-page",
              child: Container(
                decoration: BoxDecoration(
                    image: DecorationImage(
                  image: widget.image == ""
                      ? const AssetImage(MyImages.imagesUserImage)
                      : CachedNetworkImageProvider(widget.image),
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
