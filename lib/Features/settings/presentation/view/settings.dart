import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:linkify/Features/register/presentation/cubit/user_data/user_cubit.dart';
import 'package:linkify/Features/settings/presentation/view/widgets/Settings_body.dart';
import 'package:linkify/core/constants/colors.dart';
import 'package:linkify/core/constants/constants.dart';
import 'package:linkify/core/shared_logic/data/models/user.dart';
import 'package:skeletonizer/skeletonizer.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return NestedScrollView(
      headerSliverBuilder: (context, innerBoxIsScrolled) {
        return [
          const SliverAppBar(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(
                bottom: Radius.circular(10),
              ),
            ),
            leading: SizedBox(),
            title: Text(Constants.settings),
            backgroundColor: MyColors.backgroundColor,
            centerTitle: true,
          )
        ];
      },
      body: BlocBuilder<UserCubit, UserState>(
        builder: (context, state) {
          if (state is CurrentUserLoaded) {
            UserModel user = state.user;
            return SettingsBody(user: user);
          } else {
            return Skeletonizer(
              child: SettingsBody(
                  user: UserModel(
                name: '',
                image: '',
                email: '',
                phone: '',
                searchWords: [],
                isMale: true,
                isActive: true,
                password: '',
              )),
            );
          }
        },
      ),
    );
  }
}
