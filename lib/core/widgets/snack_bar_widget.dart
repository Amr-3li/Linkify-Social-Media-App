import 'package:flutter/material.dart';
import 'package:linkify/core/constants/colors.dart';

class SnackBarWidget {
  static void showSnack(BuildContext context, String messge) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Center(child: Text(messge)),
        backgroundColor: MyColors.mainChat,
        padding: const EdgeInsets.symmetric(horizontal: 10),
      ),
      snackBarAnimationStyle: AnimationStyle(
        duration: const Duration(milliseconds: 501),
        reverseDuration: const Duration(milliseconds: 500),
      ),
    );
  }
}
