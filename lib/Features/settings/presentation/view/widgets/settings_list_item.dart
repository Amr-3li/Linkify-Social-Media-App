import 'package:flutter/material.dart';
import 'package:linkify/core/constants/colors.dart';

class SettingsListItem extends StatelessWidget {
  const SettingsListItem({
    super.key,
    required this.text,
    required this.icon,
    this.trailing,
    required this.onTap,
  });

  final String text;
  final IconData icon;
  final Widget? trailing;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      leading: Icon(icon, color: MyColors.iconColor),
      title: Text(text, style: const TextStyle(fontSize: 18)),
      trailing: trailing ?? trailing,
    );
  }
}
