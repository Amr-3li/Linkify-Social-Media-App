import 'package:flutter/material.dart';
import 'package:linkify/core/constants/colors.dart';

class SnackBarWidget {
  static void showSnack(BuildContext context, String messge) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        behavior: SnackBarBehavior.floating,
        shape: const StadiumBorder(),
        margin: const EdgeInsets.all(50),
        elevation: 3,
        duration: const Duration(milliseconds: 1500),
        content: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(child: FittedBox(child: Text(messge)))),
        backgroundColor: MyColors.mainChat,
        padding: const EdgeInsets.symmetric(horizontal: 10),
      ),
      snackBarAnimationStyle: const AnimationStyle(
        duration: Duration(milliseconds: 501),
        reverseDuration: Duration(milliseconds: 500),
      ),
    );
  }
}
