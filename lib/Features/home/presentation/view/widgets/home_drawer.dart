import 'package:flutter/material.dart';
import 'package:linkify/Features/home/presentation/view/widgets/drawer_body.dart';

class HomeDrawer extends StatelessWidget {
  const HomeDrawer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Drawer(
      width: 290,
      clipBehavior: Clip.hardEdge,
      elevation: 5,
      semanticLabel: 'Navigation Drawer',
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(bottomRight: Radius.circular(250.0)),
      ),
      backgroundColor: Color.fromARGB(255, 255, 255, 255),
      child: DrawerBody(),
    );
  }
}
