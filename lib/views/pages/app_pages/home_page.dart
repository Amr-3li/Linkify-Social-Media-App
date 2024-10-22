import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:true_gym/bloc/cubit/auth/auth_cubit.dart';
import 'package:true_gym/bloc/cubit/user_data/user_cubit.dart';
import 'package:true_gym/data/models/user.dart';
import 'package:true_gym/initial.dart';
import 'package:true_gym/views/pages/app_pages/exersieses.dart';
import 'package:true_gym/views/pages/app_pages/profile.dart';
import 'package:true_gym/views/pages/app_pages/settings.dart';
import 'package:true_gym/views/widgets/basic_bages_Color.dart';
import 'package:true_gym/views/widgets/home_page_body.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      drawer: const Drawer(
        width: 290,
        clipBehavior: Clip.hardEdge,
        elevation: 5,
        semanticLabel: 'Navigation Drawer',
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(bottomRight: Radius.circular(250.0)),
        ),
        backgroundColor: const Color.fromARGB(255, 103, 103, 103),
        child: const DrawerBody(),
      ),
      floatingActionButton: SpeedDial(
        buttonSize: const Size(80, 80),
        icon: Icons.fitness_center,
        backgroundColor: const Color.fromARGB(255, 135, 135, 135),
        overlayOpacity: 0.3,
        spaceBetweenChildren: 15,
        closeManually: true,
        onPress: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const Exersieses()),
          );
        },
      ),
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(30),
          ),
        ),
        backgroundColor: const Color.fromARGB(255, 135, 135, 135),
        title: const Text(
          'True Gym',
          style: TextStyle(color: Colors.black, fontSize: 30),
        ),
      ),
      body: const HomePageBody(),
    );
  }
}

class DrawerBody extends StatelessWidget {
  const DrawerBody({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        // BlocBuilder<UserCubit, UserState>(
        //   builder: (context, state) {
        //     if (state is UserLoaded) {
        //       UserModel user = state.user;
        //       return GestureDetector(
        //         onTap: () {
        //           Navigator.pop(context);
        //           Navigator.push(
        //               context,
        //               MaterialPageRoute(
        //                   builder: (context) => const ProfilePage()));
        //         },
        //         child: UserAccountsDrawerHeader(
        //           accountName: Text(user.name.toString()),
        //           accountEmail: Text(user.email.toString()),
        //           currentAccountPicture: const CircleAvatar(
        //             backgroundImage: NetworkImage(
        //                 'https://www.pngitem.com/pimgs/m/150-1503945_transparent-user-png-default-user-image-png-png.png'),
        //           ),
        //         ),
        //       );
        //     } else {
        //       return const CircularProgressIndicator();
        //     }
        //   },
        // ),
        ListTile(
          leading: const Icon(Icons.person, color: Colors.white),
          title: const Text('Profile',
              style: TextStyle(color: Colors.white, fontSize: 20)),
          onTap: () {
            Navigator.pop(context);
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const ProfilePage()));
          },
        ),
        ListTile(
          leading: const Icon(Icons.settings, color: Colors.white),
          title: const Text('Settings',
              style: TextStyle(color: Colors.white, fontSize: 20)),
          onTap: () {
            Navigator.pop(context);
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const SettingsPage()));
          },
        ),
        const Divider(),
        const ListTile(
          leading: Icon(Icons.help, color: Colors.white),
          title:
              Text('Help', style: TextStyle(color: Colors.white, fontSize: 20)),
        ),
        const ListTile(
          leading: Icon(Icons.info, color: Colors.white),
          title: Text('About',
              style: TextStyle(color: Colors.white, fontSize: 20)),
        ),
        const Divider(),
        const ListTile(
          leading: Icon(Icons.share, color: Colors.white),
          title: Text('Share',
              style: TextStyle(color: Colors.white, fontSize: 20)),
        ),
        const ListTile(
          leading: Icon(Icons.rate_review, color: Colors.white),
          title: Text('Rate Us',
              style: TextStyle(color: Colors.white, fontSize: 20)),
        ),
        const Divider(),
        ListTile(
          leading: const Icon(Icons.logout, color: Colors.white),
          title: const Text('Logout',
              style: TextStyle(color: Colors.white, fontSize: 20)),
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
