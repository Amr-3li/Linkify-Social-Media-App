import 'package:flutter/material.dart';
import 'package:true_gym/Features/profile/presentation/view/widgets/custom_appbar_profile.dart';
import 'package:true_gym/Features/profile/presentation/view/widgets/profile_body.dart';
import 'package:true_gym/core/consts.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.backgroundColor,
      body: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) => [
                const CustomAppbarProfile(
                  name: "Profile",
                  image:
                      "https://www.pngitem.com/pimgs/m/150-1503945_transparent-user-png-default-user-image-png-png.png",
                ),
              ],
          body: const ProfileBody()),
    );
  }
}
