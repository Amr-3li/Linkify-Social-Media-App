import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:linkify/Features/profile/presentation/cubit/get_user_data/get_user_data_cubit.dart';
import 'package:linkify/Features/profile/presentation/view/widgets/custom_appbar_profile.dart';
import 'package:linkify/Features/profile/presentation/view/widgets/profile_body.dart';
import 'package:linkify/Features/profile/presentation/view/widgets/profile_information.dart';
import 'package:linkify/Features/register/data/repository/image_repo.dart';
import 'package:linkify/core/constants/constants.dart';
import 'package:linkify/core/dependicy_injection/get_it.dart';
import 'package:linkify/Features/profile/presentation/cubit/update_user/update_user_cubit.dart';
import 'package:linkify/core/constants/colors.dart';
import 'package:linkify/core/shared_logic/data/repositories/user_data_repo.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.backgroundColor,
      body: BlocBuilder<GetUserDataCubit, GetUserDataState>(
        builder: (context, state) {
          if (state is GetUserDataLoaded) {
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
                                : state.user.image!),
                      ),
                      SliverToBoxAdapter(
                        child: Container(
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                  color: MyColors.shadowColor,
                                  blurRadius: 10,
                                  offset: Offset(0, 10))
                            ],
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                          ),
                          child: ProfileInformation(user: state.user),
                        ),
                      ),
                    ],
                body: ProfileBody(
                  user: state.user,
                ));
          } else if (state is GetUserDataLoading) {
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
