import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:linkify/core/constants/constants.dart';
import 'package:linkify/core/widgets/input_text.dart';

// ignore: must_be_immutable
class UserInformations extends StatefulWidget {
  UserInformations({
    super.key,
    required this.fnameController,
    required this.lnameController,
    required this.emailController,
    required this.phoneController,
    required this.passwordController,
    required this.isMale,
    required this.isFemale,
  });

  final TextEditingController fnameController;
  final TextEditingController lnameController;
  final TextEditingController emailController;
  final TextEditingController phoneController;

  final TextEditingController passwordController;
  bool isMale, isFemale;

  @override
  State<UserInformations> createState() => _UserInformationsState();
}

class _UserInformationsState extends State<UserInformations> {
  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Column(
      children: [
        const SizedBox(height: 10),
        Row(
          children: [
            Expanded(
              child: InputTextField(
                  controller: widget.fnameController,
                  hintText: Constants.firstName.tr()),
            ),
            const SizedBox(width: 20),
            Expanded(
                child: InputTextField(
                    controller: widget.lnameController,
                    hintText: Constants.lastName.tr())),
          ],
        ),
        const SizedBox(height: 20),
        InputTextField(
            controller: widget.emailController, hintText: Constants.email.tr()),
        const SizedBox(height: 20),
        InputTextField(
            controller: widget.phoneController,
            hintText: Constants.phone.tr(),
            isnumber: true),
        const SizedBox(height: 20),
        InputTextField(
            controller: widget.passwordController,
            hintText: Constants.password.tr(),
            isPassword: true),
        const SizedBox(height: 20),
        Row(
          children: [
            Checkbox(
              value: widget.isMale,
              onChanged: (value) {
                widget.isMale = true;
                widget.isFemale = false;
                setState(() {});
              },
            ),
            Text(Constants.female.tr(),
                style: TextStyle(color: colorScheme.onSurface, fontSize: 20)),
            const SizedBox(width: 20),
            Checkbox(
              value: widget.isFemale,
              onChanged: (value) {
                widget.isMale = false;
                widget.isFemale = true;
                setState(() {});
              },
            ),
            Text(Constants.male.tr(),
                style: TextStyle(color: colorScheme.onSurface, fontSize: 20)),
          ],
        ),
        const SizedBox(height: 10),
      ],
    );
  }
}
