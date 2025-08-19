import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:linkify/core/constants/constants.dart';
import 'package:linkify/core/constants/images.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:linkify/Features/authentication/presentation/cubit/user_data/user_cubit.dart';

class PostAppBar extends StatelessWidget implements PreferredSizeWidget {
  const PostAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leadingWidth: double.infinity,
      leading: BlocBuilder<UserCubit, UserState>(
        builder: (context, state) {
          if (state is CurrentUserLoaded) {
            return SizedBox(
              width: 400,
              child: ListTile(
                leading: CircleAvatar(
                  backgroundImage: state.user.image == ""
                      ? const AssetImage(MyImages.imagesUserImage)
                      : CachedNetworkImageProvider(state.user.image!),
                ),
                title: Text(state.user.name),
              ),
            );
          } else {
            return const Skeletonizer(
              //     child: ListTile(
              //   splashColor: Colors.grey,
              // )
              child: Text(Constants.skeltonizerTextSmall1),
            );
          }
        },
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
