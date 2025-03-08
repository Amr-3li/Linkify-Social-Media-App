import 'package:flutter/material.dart';
import 'package:linkify/Features/settings/presentation/view/widgets/Settings_body.dart';
import 'package:linkify/core/constants/colors.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return NestedScrollView(
      headerSliverBuilder: (context, innerBoxIsScrolled) {
        return [
          const SliverAppBar(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(
                bottom: Radius.circular(10),
              ),
            ),
            leading: SizedBox(),
            title: Text("Settings"),
            backgroundColor: MyColors.backgroundColor,
            centerTitle: true,
          )
        ];
      },
      body: const SettingsBody(),
    );
  }
}
