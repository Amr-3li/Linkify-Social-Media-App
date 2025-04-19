import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:linkify/core/constants/constants.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:linkify/Features/home/presentation/view/widgets/user_drawer_information.dart';
import 'package:linkify/Features/register/presentation/cubit/auth/auth_cubit.dart';
import 'package:linkify/Features/register/presentation/cubit/user_data/user_cubit.dart';
import 'package:linkify/core/shared_logic/data/models/user.dart';
import 'package:linkify/core/constants/colors.dart';

class DrawerBody extends StatelessWidget {
  const DrawerBody({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        BlocBuilder<UserCubit, UserState>(
          builder: (context, state) {
            if (state is CurrentUserLoaded) {
              UserModel user = state.user;
              print(" ${user.id}    ${user.name}");
              return GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                    print(user.id);
                    GoRouter.of(context).push('/profilePage/${user.id}');
                  },
                  child: UserDrawerInformation(
                      name: user.name,
                      email: user.email,
                      image: user.image == ""
                          ? Constants.defaultUserImage
                          : user.image!));
            } else if (state is CurrentUserLoading) {
              return Skeletonizer(
                  child: UserDrawerInformation(
                name: " sdf sdgf ",
                email: "sagsdf sdf sdfgh gh sh d",
                image: Constants.defaultUserImage,
              ));
            } else if (state is CurrentUserError) {
              return Container(
                padding: const EdgeInsets.all(20),
                alignment: Alignment.center,
                child: Text(state.message.toString(),
                    style: const TextStyle(
                        color: Colors.red, fontWeight: FontWeight.bold)),
              );
            } else {
              return const SizedBox();
            }
          },
        ),
        const ListTile(
          leading: Icon(Icons.help, color: MyColors.iconColor),
          title: Text('Help',
              style: TextStyle(color: MyColors.fontColor, fontSize: 20)),
        ),
        const ListTile(
          leading: Icon(Icons.info, color: MyColors.iconColor),
          title: Text('About',
              style: TextStyle(color: MyColors.fontColor, fontSize: 20)),
        ),
        const Divider(),
        const ListTile(
          leading: Icon(Icons.share, color: MyColors.iconColor),
          title: Text('Share',
              style: TextStyle(color: MyColors.fontColor, fontSize: 20)),
        ),
        const ListTile(
          leading: Icon(Icons.rate_review, color: MyColors.iconColor),
          title: Text('Rate Us',
              style: TextStyle(color: MyColors.fontColor, fontSize: 20)),
        ),
        const Divider(),
        ListTile(
          leading:
              const Icon(Icons.logout, color: Color.fromARGB(255, 198, 0, 0)),
          title: const Text('Logout',
              style: TextStyle(color: MyColors.fontColor, fontSize: 20)),
          onTap: () {
            Navigator.pop(context);
            BlocProvider.of<AuthCubit>(context).signout();
            GoRouter.of(context).push('/initialPage');
          },
        ),
      ],
    );
  }
}
