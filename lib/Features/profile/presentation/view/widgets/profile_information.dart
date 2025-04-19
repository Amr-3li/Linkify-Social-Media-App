import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:linkify/Features/profile/presentation/view/widgets/dialog_body.dart';
import 'package:linkify/Features/profile/presentation/view/widgets/information_component.dart';
import 'package:linkify/Features/register/presentation/cubit/user_data/user_cubit.dart';
import 'package:linkify/core/constants/colors.dart';
import 'package:linkify/core/dependicy_injection/get_it.dart';
import 'package:linkify/core/shared_logic/data/models/user.dart';
import 'package:linkify/core/shared_logic/data/repositories/user_data_repo.dart';
import 'package:linkify/core/widgets/custom_button.dart';
import 'package:linkify/core/widgets/snack_bar_widget.dart';

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
            type: "Email",
            text: user.email,
            icon: const Icon(Icons.email, color: Colors.red)),

        InformationComponent(
          type: "Name",
          text: user.name,
          icon: const Icon(Icons.person, color: Colors.blueAccent),
        ),

        InformationComponent(
          type: "Phone ",
          text: user.phone,
          icon: const Icon(
            Icons.phone,
            color: Colors.green,
          ),
        ),

        InformationComponent(
          type: "Gender ",
          text: user.isMale ? "Male" : "Female",
          icon: Icon(
            user.isMale ? Icons.male : Icons.female,
            color: user.isMale ? Colors.blue : Colors.pink,
          ),
        ),

        const SizedBox(height: 20),
        SizedBox(
          width: 200,
          height: 40,
          child: CustomButton(
              title: "Edit Profile",
              color: MyColors.buttonColor,
              onTap: () {
                openDialog(context);
                SnackBarWidget.showSnack(
                    context, "Profile updated successfully");
              }),
        ),
        const SizedBox(height: 10),
        // Add more user details here
      ],
    );
  }

  Future openDialog(BuildContext context) => showDialog(
        context: context,
        builder: (context) => AlertDialog(
          backgroundColor: Colors.white,
          contentPadding: const EdgeInsets.all(10),
          content: BlocProvider(
            create: (context) => UserCubit(gitItInstanse<UserDataRepo>()),
            child: DialogBody(
              user: user,
            ),
          ),
        ),
      );
}
