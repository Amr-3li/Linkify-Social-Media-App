import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:linkify/core/constants/constants.dart';

class ListTitle extends StatelessWidget {
  const ListTitle({
    super.key,
    required this.title,
    required this.icon,
    this.onTap,
  });
  final String title;
  final IconData icon;
  final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title,
          style: TextStyle(
              color: Theme.of(context).colorScheme.onSurface, fontSize: 20)),
      leading: Icon(icon, color: Colors.grey),
      trailing: Text(Constants.seeAll.tr(),
          style: TextStyle(color: Colors.grey, fontSize: 16)),
      tileColor: Theme.of(context).colorScheme.surfaceVariant,
      onTap: onTap,
    );
  }
}
