import 'package:flutter/material.dart';
import 'package:true_gym/Features/settings/presentation/view/widgets/settings_list_item.dart';
import 'package:true_gym/Features/settings/presentation/view/widgets/settings_list_name_component.dart';

class SettingsBody extends StatelessWidget {
  const SettingsBody({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        ListNameComponent(name: "GENERAL"),
        SettingsListItem(
            text: "language", icon: Icons.language, trailingText: "English"),
        SettingsListItem(
            text: "theme", icon: Icons.brightness_4, trailingText: "Light"),
        SettingsListItem(text: "notifications", icon: Icons.notifications),
      ],
    );
  }
}
