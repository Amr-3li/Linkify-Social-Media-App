import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:linkify/Features/profile/presentation/view/widgets/custom_appbar_profile.dart';
import 'package:linkify/Features/profile/presentation/view/widgets/profile_body.dart';
import 'package:linkify/Features/register/data/repository/image_repo.dart';
import 'package:linkify/core/constants/constants.dart';
import 'package:linkify/core/dependicy_injection/get_it.dart';
import 'package:linkify/Features/profile/presentation/cubit/update_user/update_user_cubit.dart';
import 'package:linkify/Features/register/presentation/cubit/user_data/user_cubit.dart';
import 'package:linkify/core/constants/colors.dart';
import 'package:linkify/core/shared_logic/data/repositories/user_data_repo.dart';

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
                      BlocProvider(
                        create: (context) => UpdateUserCubit(
                            gitItInstanse<ImageRepo>(),
                            gitItInstanse<UserDataRepo>()),
                        child: CustomAppbarProfile(
                          name: state.user.fname,
                          image: state.user.image == ""
                              ? Constants.defaultUserImage
                              : state.user.image!,
                        ),
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
