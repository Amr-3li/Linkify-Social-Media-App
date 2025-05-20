import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:linkify/Features/register/presentation/cubit/user_data/user_cubit.dart';
import 'package:linkify/Features/settings/presentation/view/widgets/dialog_body.dart';
import 'package:linkify/Features/settings/presentation/view/widgets/settings_list_item.dart';
import 'package:linkify/Features/settings/presentation/view/widgets/settings_list_name_component.dart';
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
          const ListNameComponent(name: "GENERAL"),
          const SettingsListItem(
              text: "language",
              icon: Icons.language,
              trailingText: "English",
              onTap: null),
          const SettingsListItem(
              text: "theme",
              icon: Icons.brightness_4,
              trailingText: "Light",
              onTap: null),
          const SettingsListItem(
              text: "notifications", icon: Icons.notifications, onTap: null),
          const ListNameComponent(name: "ACCOUNT"),
          SettingsListItem(
              text: "edit profile",
              icon: Icons.person,
              onTap: () {
                openDialog(context);
                SnackBarWidget.showSnack(
                    context, "Profile updated successfully");
              }),
          const SettingsListItem(
              text: "change password", icon: Icons.password, onTap: null),
          const ListNameComponent(name: "HELP"),
          const SettingsListItem(
              text: "contact us", icon: Icons.contact_page, onTap: null),
          const SettingsListItem(
              text: "about us", icon: Icons.info, onTap: null),
          const ListNameComponent(name: "OTHERS"),
          const SettingsListItem(
              text: "logout", icon: Icons.logout, onTap: null),
        ],
      ),
    );
  }

  Future openDialog(BuildContext context) => showDialog(
        context: context,
        builder: (context) => AlertDialog(
          backgroundColor: Colors.white,
          contentPadding: const EdgeInsets.all(10),
          content: BlocProvider(
            create: (context) => UserCubit(gitItInstanse<UserDataRepo>()),
            child: DialogBody(
              user: user,
            ),
          ),
        ),
      );
}
