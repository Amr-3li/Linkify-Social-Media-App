import 'package:flutter/material.dart';

class SnackBarWidget {
  static void showSnack(BuildContext context, String messge) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(messge)));
  }
}
