import 'package:flutter/material.dart';
import 'package:true_gym/consts.dart';

class HomeAppbar extends StatelessWidget implements PreferredSizeWidget {
  const HomeAppbar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 2,
      shadowColor:
          MyColors.shadowColor, // Ensure MyColors is defined and imported
      centerTitle: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(10),
        ),
      ),
      backgroundColor: Colors.white,
      title: const Text(
        'True Gym',
        style: TextStyle(color: Colors.black, fontSize: 30),
      ),
    );
  }

  // Define preferredSize for AppBar's height
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
