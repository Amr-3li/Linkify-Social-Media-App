import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:true_gym/Features/register/presentation/cubit/user_data/user_cubit.dart';

class PostAppBar extends StatelessWidget implements PreferredSizeWidget {
  const PostAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leadingWidth: double.infinity,
      leading: BlocBuilder<UserCubit, UserState>(
        builder: (context, state) {
          if (state is UserLoaded) {
            return SizedBox(
              width: 400,
              child: ListTile(
                leading: CircleAvatar(
                  backgroundImage: NetworkImage(
                    state.user.image == ""
                        ? "https://www.pngitem.com/pimgs/m/150-1503945_transparent-user-png-default-user-image-png-png.png"
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
