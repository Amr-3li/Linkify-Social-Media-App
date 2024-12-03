import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:true_gym/Features/profile/presentation/view/widgets/custom_appbar_profile.dart';
import 'package:true_gym/Features/profile/presentation/view/widgets/profile_body.dart';
import 'package:true_gym/Features/register/data/model/user.dart';
import 'package:true_gym/Features/register/presentation/cubit/user_data/user_cubit.dart';
import 'package:true_gym/core/utils/consts.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.backgroundColor,
      body: BlocBuilder<UserCubit, UserState>(
        builder: (context, state) {
          if (state is UserLoaded) {
            return NestedScrollView(
                headerSliverBuilder: (context, innerBoxIsScrolled) => [
                      CustomAppbarProfile(
                        name: state.user.fname,
                        image: state.user.image == null
                            ? "https://www.pngitem.com/pimgs/m/150-1503945_transparent-user-png-default-user-image-png-png.png"
                            : state.user.image!,
                      ),
                    ],
                body: ProfileBody(
                  user: state.user,
                ));
          } else if (state is UserLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return const Center(
              child: Text("Error"),
            );
          }
        },
      ),
    );
  }
}
