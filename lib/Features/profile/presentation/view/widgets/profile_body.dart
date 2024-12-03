import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:true_gym/Features/profile/presentation/view/widgets/information_component.dart';
import 'package:true_gym/Features/profile/presentation/view/widgets/profile_information.dart';
import 'package:true_gym/Features/register/presentation/cubit/user_data/user_cubit.dart';
import 'package:true_gym/Features/register/data/model/user.dart';
import 'package:true_gym/core/utils/consts.dart';
import 'package:true_gym/views/widgets/custom_button.dart';

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
            const SizedBox(height: 20),
            CustomButton(
              title: "Edit Profile",
              color: Colors.blue,
              onTap: () => GoRouter.of(context).push('/editProfilePage'),
            ),
          ],
        ),
      ),
    );
  }
}
