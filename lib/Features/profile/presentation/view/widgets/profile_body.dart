import 'package:flutter/material.dart';

import 'package:linkify/Features/profile/presentation/view/widgets/profile_information.dart';
import 'package:linkify/core/constants/colors.dart';
import 'package:linkify/core/shared_logic/data/models/user.dart';

class ProfileBody extends StatelessWidget {
  const ProfileBody({super.key, required this.user});
  final UserModel user;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 10),
              decoration: const BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                      color: MyColors.shadowColor,
                      blurRadius: 20,
                      offset: Offset(0, 10))
                ],
                borderRadius: BorderRadius.all(Radius.circular(20)),
              ),
              child: ProfileInformation(user: user),
            ),
          ],
        ),
      ),
    );
  }
}
