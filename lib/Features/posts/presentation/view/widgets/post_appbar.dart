import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:linkify/core/constants/constants.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:linkify/Features/register/presentation/cubit/user_data/user_cubit.dart';
import 'package:linkify/core/constants/colors.dart';

class PostAppBar extends StatelessWidget implements PreferredSizeWidget {
  const PostAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: MyColors.appBarColor,
      leadingWidth: double.infinity,
      leading: BlocBuilder<UserCubit, UserState>(
        builder: (context, state) {
          if (state is CurrentUserLoaded) {
            return SizedBox(
              width: 400,
              child: ListTile(
                leading: CircleAvatar(
                  backgroundImage: NetworkImage(
                    state.user.image == ""
                        ? Constants.defaultUserImage
                        : state.user.image!,
                  ),
                ),
                title: Text("${state.user.fname} ${state.user.lname}"),
              ),
            );
          } else {
            return const Skeletonizer(
              //     child: ListTile(
              //   splashColor: Colors.grey,
              // )
              child: Text("asdda"),
            );
          }
        },
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
