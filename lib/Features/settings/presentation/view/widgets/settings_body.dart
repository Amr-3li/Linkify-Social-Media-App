import 'package:flutter/material.dart';
import 'package:linkify/Features/settings/presentation/cubit/change_theme/change_theme_cubit.dart';
import 'package:linkify/Features/settings/presentation/cubit/reset_pass/reset_pass_cubit.dart';
import 'package:linkify/Features/settings/presentation/view/widgets/dialog_body.dart';
import 'package:linkify/Features/settings/presentation/view/widgets/settings_list_item.dart';
import 'package:linkify/Features/settings/presentation/view/widgets/settings_list_name_component.dart';
import 'package:linkify/core/constants/colors.dart';
import 'package:linkify/core/constants/constants.dart';
import 'package:linkify/core/exports/app_router.dart';
import 'package:linkify/core/shared_logic/data/models/user.dart';
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
              text: Constants.language, icon: Icons.language, onTap: null),
          BlocBuilder<ChangeThemeCubit, ChangeThemeState>(
            builder: (context, state) {
              if (state is ChangeThemeLoaded) {
                return SettingsListItem(
                    text: Constants.theme,
                    icon: Icons.brightness_4,
                    trailing: Switch(
                      value: state.isDarkMode,
                      onChanged: (value) {
                        context.read<ChangeThemeCubit>().changeTheme();
                      },
                      activeColor: Theme.of(context).colorScheme.primary,
                      activeTrackColor: MyColors.light,
                      inactiveThumbColor: Theme.of(context).colorScheme.primary,
                      inactiveTrackColor: MyColors.light,
                    ),
                    onTap: null);
              } else {
                return const SettingsListItem(
                    text: Constants.theme,
                    icon: Icons.brightness_4,
                    trailing: Switch(
                      value: false,
                      onChanged: null,
                      activeColor: MyColors.light,
                      activeTrackColor: MyColors.light,
                      inactiveThumbColor: MyColors.light,
                      inactiveTrackColor: MyColors.light,
                    ),
                    onTap: null);
              }
            },
          ),
          const ListNameComponent(name: Constants.account),
          SettingsListItem(
              text: Constants.editProfile,
              icon: Icons.person,
              onTap: () async {
                await openDialog(context);
                SnackBarWidget.showSnack(context, Constants.profileUpdated);
              }),
          BlocListener<ResetPassCubit, ResetPassState>(
            listener: (context, state) {
              if (state is ResetPassLoading) {
                SnackBarWidget.showSnack(context, Constants.sendEmail);
              } else if (state is ResetPassSuccess) {
                SnackBarWidget.showSnack(context, Constants.emailSent);
              } else if (state is ResetPassFailure) {
                SnackBarWidget.showSnack(context, state.errorMessage);
              }
            },
            child: SettingsListItem(
                text: Constants.changePassword,
                icon: Icons.password,
                onTap: () async {
                  await BlocProvider.of<ResetPassCubit>(context).resetPass();
                }),
          ),
          const ListNameComponent(name: Constants.helping),
          SettingsListItem(
              text: Constants.help,
              icon: Icons.contact_page,
              onTap: () {
                GoRouter.of(context).push(HelpPage.routeName);
              }),
          SettingsListItem(
              text: Constants.aboutUs,
              icon: Icons.info,
              onTap: () {
                GoRouter.of(context).push(AboutUsPage.routeName);
              }),
          const ListNameComponent(name: Constants.others),
          SettingsListItem(
              text: Constants.logout,
              icon: Icons.logout,
              onTap: () {
                context.read<AuthCubit>().signout();
                GoRouter.of(context).pushReplacement(LoginPage.routeName);
              }),
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
