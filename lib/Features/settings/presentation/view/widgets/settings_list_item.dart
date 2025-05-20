import 'package:flutter/material.dart';
import 'package:linkify/core/constants/colors.dart';

class SettingsListItem extends StatelessWidget {
  const SettingsListItem({
    super.key,
    required this.text,
    required this.icon,
    this.trailingText,
    required this.onTap,
  });

  final String text;
  final IconData icon;
  final String? trailingText;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      leading: Icon(icon, color: MyColors.iconColor),
      title: Text(text, style: const TextStyle(fontSize: 18)),
      trailing: trailingText == null
          ? null
          : Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(trailingText!,
                    style: const TextStyle(fontSize: 15, color: Colors.grey)),
                const SizedBox(width: 10),
                Transform.rotate(
                    angle: 1.5708,
                    child: const Icon(Icons.arrow_forward_ios, size: 15)),
              ],
            ),
    );
  }
}
