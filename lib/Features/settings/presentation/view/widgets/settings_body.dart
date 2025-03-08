import 'package:flutter/material.dart';
import 'package:linkify/Features/settings/presentation/view/widgets/settings_list_item.dart';
import 'package:linkify/Features/settings/presentation/view/widgets/settings_list_name_component.dart';

class SettingsBody extends StatelessWidget {
  const SettingsBody({super.key});

  @override
  Widget build(BuildContext context) {
    return const SingleChildScrollView(
      child: Column(
        children: [
          ListNameComponent(name: "GENERAL"),
          SettingsListItem(
              text: "language", icon: Icons.language, trailingText: "English"),
          SettingsListItem(
              text: "theme", icon: Icons.brightness_4, trailingText: "Light"),
          SettingsListItem(text: "notifications", icon: Icons.notifications),
          ListNameComponent(name: "ACCOUNT"),
          SettingsListItem(text: "edit profile", icon: Icons.person),
          SettingsListItem(text: "change password", icon: Icons.password),
          ListNameComponent(name: "HELP"),
          SettingsListItem(text: "contact us", icon: Icons.contact_page),
          SettingsListItem(text: "about us", icon: Icons.info),
          ListNameComponent(name: "OTHERS"),
          SettingsListItem(text: "logout", icon: Icons.logout),
        ],
      ),
    );
  }
}
