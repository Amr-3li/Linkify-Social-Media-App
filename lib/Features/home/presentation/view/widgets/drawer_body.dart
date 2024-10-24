import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:true_gym/bloc/cubit/auth/auth_cubit.dart';
import 'package:true_gym/bloc/cubit/user_data/user_cubit.dart';
import 'package:true_gym/consts.dart';
import 'package:true_gym/data/models/user.dart';
import 'package:true_gym/initial.dart';
import 'package:true_gym/Features/profile/presentation/view/profile.dart';
import 'package:true_gym/views/pages/app_pages/settings.dart';

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
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const ProfilePage()));
                },
                child: UserAccountsDrawerHeader(
                  decoration: const BoxDecoration(color: MyColors.appBarColor),
                  accountName: Text(user.name.toString()),
                  accountEmail: Text(user.email.toString()),
                  currentAccountPicture: const CircleAvatar(
                    backgroundImage: NetworkImage(
                        'https://www.pngitem.com/pimgs/m/150-1503945_transparent-user-png-default-user-image-png-png.png'),
                  ),
                ),
              );
            } else {
              return const CircularProgressIndicator();
            }
          },
        ),
        ListTile(
          leading: const Icon(Icons.person, color: MyColors.iconColor),
          title: const Text('Profile',
              style: TextStyle(color: MyColors.fontColor, fontSize: 20)),
          onTap: () {
            Navigator.pop(context);
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const ProfilePage()));
          },
        ),
        ListTile(
          leading: const Icon(Icons.settings, color: MyColors.iconColor),
          title: const Text('Settings',
              style: TextStyle(color: MyColors.fontColor, fontSize: 20)),
          onTap: () {
            Navigator.pop(context);
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const SettingsPage()));
          },
        ),
        const Divider(),
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
          leading: const Icon(Icons.logout, color: MyColors.iconColor),
          title: const Text('Logout',
              style: TextStyle(color: MyColors.fontColor, fontSize: 20)),
          onTap: () {
            Navigator.pop(context);
            BlocProvider.of<AuthCubit>(context).signout();
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => const InitialPage()));
          },
        ),
      ],
    );
  }
}
