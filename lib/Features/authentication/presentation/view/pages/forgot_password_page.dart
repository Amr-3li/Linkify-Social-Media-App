import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:linkify/Features/authentication/presentation/cubit/auth/auth_cubit.dart';
import 'package:linkify/core/constants/constants.dart';
import 'package:linkify/core/widgets/custom_appbar.dart';
import 'package:linkify/core/widgets/input_text.dart';

class ForgotPasswordPage extends StatelessWidget {
  const ForgotPasswordPage({super.key});
  static const String routeName = '/forgotPassword';
  @override
  Widget build(BuildContext context) {
    TextEditingController emailControler = TextEditingController();
    return Scaffold(
      appBar: CustomAppbar(title: Constants.resetPassword.tr()),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            Constants.enterYourEmail.tr(),
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: InputTextField(
              hintText: Constants.email.tr(),
              controller: emailControler,
              color: Theme.of(context).colorScheme.secondary,
            ),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () async {
              await BlocProvider.of<AuthCubit>(context)
                  .resetePassword(emailControler.text.toString());
              GoRouter.of(context).pop();
            },
            style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).colorScheme.secondary,
                fixedSize: const Size(300, 50)),
            child: Text(
              Constants.resetPassword.tr(),
              style: TextStyle(fontSize: 20),
            ),
          )
        ],
      ),
    );
  }
}
