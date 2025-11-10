import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:linkify/Features/settings/data/repo/reset_pass_repo.dart';
import 'package:linkify/Features/settings/presentation/cubit/reset_pass/reset_pass_cubit.dart';
import 'package:linkify/core/constants/constants.dart';
import 'package:linkify/core/exports/app_router.dart';
import 'package:linkify/core/utils/validation.dart';
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
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppbar(title: Constants.changePassword),
        body: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Form(
            key: formKey,
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
                BlocProvider(
                  create: (context) =>
                      ResetPassCubit(gitItInstanse<ResetPassRepo>()),
                  child: BlocConsumer<ResetPassCubit, ResetPassState>(
                    listener: (context, state) {
                      if (state is ResetPassSuccess) {
                        SnackBarWidget.showSnack(
                            context, Constants.passwordChanged.tr());
                        oldPassword.clear();
                        newPassword.clear();
                        confirmNewPassword.clear();
                      } else if (state is ResetPassFailure) {
                        SnackBarWidget.showSnack(
                            context, Constants.passwordChanged.tr());
                      }
                    },
                    builder: (context, state) {
                      if (state is ResetPassLoading) {
                        return const Center(child: CircularProgressIndicator());
                      }
                      return CustomButton(
                        onTap: () {
                          if (!vlaidaion(context)) {
                            return;
                          }
                          context.read<ResetPassCubit>().resetPass(
                              oldPass: oldPassword.text,
                              newPass: newPassword.text);
                        },
                        title: Constants.save.tr(),
                        color: Theme.of(context).colorScheme.secondary,
                      );
                    },
                  ),
                )
              ],
            ),
          ),
        ));
  }

  bool vlaidaion(BuildContext context) {
    if (formKey.currentState != null && !formKey.currentState!.validate()) {
      return false;
    }
    final result = ValidationUtil.validatePassword(newPassword.text);
    if (!result.isValid) {
      SnackBarWidget.showSnack(context, result.errorMessage!.tr());
      return false;
    }
    final resultcompare = ValidationUtil.validateConfirmPassword(
        newPassword.text, confirmNewPassword.text);
    if (!resultcompare.isValid) {
      SnackBarWidget.showSnack(context, resultcompare.errorMessage!.tr());
      return false;
    }
    return true;
  }
}
