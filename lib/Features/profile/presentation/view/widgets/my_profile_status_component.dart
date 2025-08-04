import 'package:flutter/material.dart';
import 'package:linkify/core/constants/constants.dart';

class MyProfileStatusComponent extends StatelessWidget {
  const MyProfileStatusComponent({super.key});
  @override
  Widget build(BuildContext context) {
    return const Center(child: Text(Constants.myProfile));
  }
}
