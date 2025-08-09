import 'package:flutter/material.dart';
import 'package:linkify/Features/home/presentation/view/widgets/drawer_body.dart';
import 'package:linkify/core/constants/colors.dart';

class HomeDrawer extends StatelessWidget {
  const HomeDrawer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: 290,
      clipBehavior: Clip.hardEdge,
      elevation: 5,
      semanticLabel: 'Navigation Drawer',
      shape: const RoundedRectangleBorder(
        borderRadius:
            const BorderRadius.only(bottomRight: const Radius.circular(250.0)),
      ),
      backgroundColor: Theme.of(context).colorScheme.background,
      child: const DrawerBody(),
    );
  }
}
