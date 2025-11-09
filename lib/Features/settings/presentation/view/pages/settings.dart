import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:linkify/Features/authentication/presentation/cubit/user_data/user_cubit.dart';
import 'package:linkify/Features/settings/presentation/view/widgets/Settings_body.dart';
import 'package:linkify/core/constants/constants.dart';
import 'package:linkify/core/shared_logic/data/models/user.dart';
import 'package:skeletonizer/skeletonizer.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});
  static const String routeName = '/settingsPage';
  @override
  Widget build(BuildContext context) {
    return NestedScrollView(
      headerSliverBuilder: (context, innerBoxIsScrolled) {
        return [
          SliverAppBar(
            leading: const SizedBox(),
            title: Text(Constants.settings.tr(),
                style: TextStyle(fontSize: 25, color: Colors.white)),
            backgroundColor: Theme.of(context).colorScheme.primary,
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
