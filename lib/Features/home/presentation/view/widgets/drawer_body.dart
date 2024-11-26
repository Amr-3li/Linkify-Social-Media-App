import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:true_gym/Features/home/presentation/view/widgets/user_drawer_information.dart';
import 'package:true_gym/Features/register/presentation/cubit/auth/auth_cubit.dart';
import 'package:true_gym/Features/register/presentation/cubit/user_data/user_cubit.dart';
import 'package:true_gym/Features/register/data/model/user.dart';
import 'package:true_gym/core/utils/consts.dart';
import 'package:true_gym/initial.dart';

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
            if (state is UserLoaded) {
              UserModel user = state.user;
              return GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                  GoRouter.of(context).push('/profilePage');
                },
                child: UserDrawerInformation(
                    name: "${user.fname} ${user.lname}",
                    email: user.email,
                    image:
                        'https://www.pngitem.com/pimgs/m/150-1503945_transparent-user-png-default-user-image-png-png.png'),
              );
            } else if (state is UserLoading) {
              return const Skeletonizer(
                  child: UserDrawerInformation(
                name: "",
                email: "",
                image:
                    'https://www.pngitem.com/pimgs/m/150-1503945_transparent-user-png-default-user-image-png-png.png',
              ));
            } else if (state is UserError) {
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
          tileColor: MyColors.appBarColor,
          leading: const Icon(Icons.logout, color: MyColors.iconColor),
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
