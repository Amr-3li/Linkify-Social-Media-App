import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:linkify/Features/register/presentation/cubit/user_data/user_cubit.dart';
import 'package:linkify/Features/settings/presentation/view/widgets/dialog_body.dart';
import 'package:linkify/Features/settings/presentation/view/widgets/settings_list_item.dart';
import 'package:linkify/Features/settings/presentation/view/widgets/settings_list_name_component.dart';
import 'package:linkify/core/constants/constants.dart';
import 'package:linkify/core/dependicy_injection/get_it.dart';
import 'package:linkify/core/shared_logic/data/models/user.dart';
import 'package:linkify/core/shared_logic/data/repositories/user_data_repo.dart';
import 'package:linkify/core/widgets/snack_bar_widget.dart';

class SettingsBody extends StatelessWidget {
  const SettingsBody({super.key, required this.user});
  final UserModel user;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          const ListNameComponent(name: Constants.general),
          const SettingsListItem(
              text: Constants.language,
              icon: Icons.language,
              trailingText: Constants.english,
              onTap: null),
          const SettingsListItem(
              text: Constants.theme,
              icon: Icons.brightness_4,
              trailingText: Constants.light,
              onTap: null),
          const SettingsListItem(
              text: Constants.notifications,
              icon: Icons.notifications,
              onTap: null),
          const ListNameComponent(name: Constants.account),
          SettingsListItem(
              text: Constants.editProfile,
              icon: Icons.person,
              onTap: () {
                openDialog(context);
                SnackBarWidget.showSnack(context, Constants.profileUpdated);
              }),
          const SettingsListItem(
              text: Constants.changePassword,
              icon: Icons.password,
              onTap: null),
          const ListNameComponent(name: Constants.help),
          const SettingsListItem(
              text: Constants.contact, icon: Icons.contact_page, onTap: null),
          const SettingsListItem(
              text: Constants.aboutUs, icon: Icons.info, onTap: null),
          const ListNameComponent(name: Constants.others),
          const SettingsListItem(
              text: Constants.logout, icon: Icons.logout, onTap: null),
        ],
      ),
    );
  }

  Future openDialog(BuildContext context) => showDialog(
        context: context,
        builder: (context) => AlertDialog(
          contentPadding: const EdgeInsets.all(0),
          content: BlocProvider(
            create: (context) => UserCubit(gitItInstanse<UserDataRepo>()),
            child: DialogBody(
              user: user,
            ),
          ),
        ),
      );
}
