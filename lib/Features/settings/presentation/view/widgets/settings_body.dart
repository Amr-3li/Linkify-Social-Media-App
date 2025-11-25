import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:linkify/Features/settings/presentation/cubit/change_theme/change_theme_cubit.dart';
import 'package:linkify/Features/settings/presentation/cubit/reset_pass/reset_pass_cubit.dart';
import 'package:linkify/Features/settings/presentation/view/pages/change_password.dart';
import 'package:linkify/Features/settings/presentation/view/pages/language.dart';
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
          ListNameComponent(name: Constants.general.tr()),
          SettingsListItem(
              text: Constants.language.tr(),
              icon: Icons.language,
              onTap: () {
                GoRouter.of(context).push(LanguagePage.routeName);
              }),
          BlocBuilder<ChangeThemeCubit, ChangeThemeState>(
            builder: (context, state) {
              if (state is ChangeThemeLoaded) {
                return SettingsListItem(
                    text: Constants.theme.tr(),
                    icon: Icons.brightness_4,
                    trailing: Switch(
                      value: state.isDarkMode,
                      onChanged: (value) {
                        context.read<ChangeThemeCubit>().changeTheme();
                      },
                      activeThumbColor: Theme.of(context).colorScheme.primary,
                      activeTrackColor: MyColors.light,
                      inactiveThumbColor: Theme.of(context).colorScheme.primary,
                      inactiveTrackColor: MyColors.light,
                    ),
                    onTap: null);
              } else {
                return SettingsListItem(
                    text: Constants.theme.tr(),
                    icon: Icons.brightness_4,
                    trailing: Switch(
                      value: false,
                      onChanged: null,
                      activeThumbColor: MyColors.light,
                      activeTrackColor: MyColors.light,
                      inactiveThumbColor: MyColors.light,
                      inactiveTrackColor: MyColors.light,
                    ),
                    onTap: null);
              }
            },
          ),
          ListNameComponent(name: Constants.account.tr()),
          SettingsListItem(
              text: Constants.editProfile.tr(),
              icon: Icons.person,
              onTap: () async {
                await openDialog(context);
                SnackBarWidget.showSnack(
                    context, Constants.profileUpdated.tr());
              }),
          BlocListener<ResetPassCubit, ResetPassState>(
            listener: (context, state) {
              if (state is ResetPassLoading) {
                SnackBarWidget.showSnack(context, Constants.sendEmail.tr());
              } else if (state is ResetPassSuccess) {
                SnackBarWidget.showSnack(context, Constants.emailSent.tr());
              } else if (state is ResetPassFailure) {
                SnackBarWidget.showSnack(context, state.errorMessage.tr());
              }
            },
            child: SettingsListItem(
                text: Constants.changePassword.tr(),
                icon: Icons.password,
                onTap: () async {
                  GoRouter.of(context).push(ChangePassword.routeName);
                }),
          ),
          ListNameComponent(name: Constants.helping.tr()),
          SettingsListItem(
              text: Constants.help.tr(),
              icon: Icons.contact_page,
              onTap: () {
                GoRouter.of(context).push(HelpPage.routeName);
              }),
          SettingsListItem(
              text: Constants.aboutUs.tr(),
              icon: Icons.info,
              onTap: () async {
                GoRouter.of(context).push(AboutUsPage.routeName);
              }),
          ListNameComponent(name: Constants.others.tr()),
          SettingsListItem(
              text: Constants.logout.tr(),
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
