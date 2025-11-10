import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:linkify/core/constants/constants.dart';
import 'package:linkify/core/widgets/custom_appbar.dart';
import 'package:linkify/core/widgets/custom_button.dart';
import 'package:linkify/core/widgets/input_text.dart';
import 'package:linkify/core/widgets/snack_bar_widget.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({super.key});
  static const String routeName = '/changePasswordPage';

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  final TextEditingController oldPassword = TextEditingController();
  final TextEditingController newPassword = TextEditingController();
  final TextEditingController confirmNewPassword = TextEditingController();
  bool seenOldPassword = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppbar(title: Constants.changePassword),
        body: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              SizedBox(height: 16),
              InputTextField(
                hintText: Constants.oldPassword.tr(),
                controller: oldPassword,
                color: Theme.of(context).colorScheme.onSurface,
                isPassword: seenOldPassword,
                suffixIcon: InkWell(
                  onTap: () {
                    setState(() {
                      seenOldPassword = !seenOldPassword;
                    });
                  },
                  child: Icon(
                    seenOldPassword ? Icons.visibility : Icons.visibility_off,
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                ),
              ),
              SizedBox(height: 16),
              InputTextField(
                  hintText: Constants.newPassword.tr(),
                  controller: newPassword,
                  color: Theme.of(context).colorScheme.onSurface,
                  isPassword: true),
              SizedBox(height: 16),
              InputTextField(
                hintText: Constants.confirmNewPassword.tr(),
                controller: confirmNewPassword,
                isPassword: true,
                color: Theme.of(context).colorScheme.onSurface,
                onChanged: (_) {},
              ),
              SizedBox(height: 16),
              CustomButton(
                onTap: () {
                  oldPassword.clear();
                  newPassword.clear();
                  confirmNewPassword.clear();
                },
                title: Constants.save.tr(),
                color: Theme.of(context).colorScheme.secondary,
              )
            ],
          ),
        ));
  }
}
