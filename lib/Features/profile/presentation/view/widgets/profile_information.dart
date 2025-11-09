import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:linkify/Features/profile/presentation/view/widgets/information_component.dart';
import 'package:linkify/core/constants/constants.dart';
import 'package:linkify/core/shared_logic/data/models/user.dart';

class ProfileInformation extends StatelessWidget {
  const ProfileInformation({
    super.key,
    required this.user,
  });
  final UserModel user;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InformationComponent(
          type: Constants.name.tr(),
          text: user.name,
          icon: const Icon(Icons.person, color: Colors.blueAccent),
        ),

        InformationComponent(
            type: Constants.email.tr(),
            text: user.email,
            icon: const Icon(Icons.email, color: Colors.red)),

        InformationComponent(
          type: Constants.phone.tr(),
          text: user.phone,
          icon: const Icon(Icons.phone, color: Colors.green),
        ),

        InformationComponent(
          type: Constants.gender.tr(),
          text: user.isMale ? Constants.male.tr() : Constants.female.tr(),
          icon: Icon(
            user.isMale ? Icons.male : Icons.female,
            color: user.isMale ? Colors.blue : Colors.pink,
          ),
        ),

        user.about != "" && user.about != null
            ? InformationComponent(
                type: Constants.about.tr(),
                text: user.about!,
                icon: const Icon(Icons.info, color: Colors.purple),
              )
            : const SizedBox(),

        // const SizedBox(height: 20),
        // SizedBox(
        //   width: 200,
        //   height: 40,
        //   child: CustomButton(
        //       title: "Edit Profile",
        //       color: MyColors.buttonColor,
        //       onTap: () {
        //         openDialog(context);
        //         SnackBarWidget.showSnack(
        //             context, "Profile updated successfully");
        //       }),
        // ),
        const SizedBox(height: 10),
        // Add more user details here
      ],
    );
  }
}
