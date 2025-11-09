import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:linkify/Features/authentication/presentation/view/widgets/auth_background.dart';
import 'package:linkify/core/constants/constants.dart';
import 'package:linkify/core/exports/app_router.dart';
import 'package:linkify/core/shared_logic/data/models/user.dart';
import 'package:linkify/Features/authentication/presentation/view/widgets/user_image.dart';
import 'package:linkify/Features/authentication/presentation/view/widgets/user_informations.dart';
import 'package:linkify/core/widgets/snack_bar_widget.dart';

// ignore: must_be_immutable
class SignupPage extends StatefulWidget {
  const SignupPage({super.key});
  static const String routeName = '/signupPage';
  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  bool isMale = true;

  bool isFemale = false;

  bool isTrainer = false;

  String? image;
  File? imageFile;

  TextEditingController emailController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  TextEditingController fnameController = TextEditingController();

  TextEditingController lnameController = TextEditingController();

  TextEditingController phoneController = TextEditingController();

  final keyform = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SignUpCupit, SignUpState>(
      listener: (context, state) {
        if (state is SignUpSuccess) {
          SnackBarWidget.showSnack(
              context, Constants.userCreatedSuccessfully.tr());
          GoRouter.of(context).pop();
        } else if (state is SignUpError) {
          SnackBarWidget.showSnack(context, state.message);
        }
      },
      builder: (context, state) {
        return Scaffold(
          body: AuthBackground(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              primary: true,
              child: SizedBox(
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    const SizedBox(
                      height: 50,
                    ),
                    Text(
                      Constants.signUpPage.tr(),
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.onSurface,
                          fontSize: 36,
                          fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 10),
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.transparent,
                      ),
                      child: Form(
                        key: keyform,
                        child: Column(
                          children: [
                            const SizedBox(height: 30),
                            UserImage(
                              image: (image) {
                                imageFile = image;
                              },
                            ),
                            const SizedBox(height: 10),
                            UserInformations(
                              isFemale: isFemale,
                              isMale: isMale,
                              fnameController: fnameController,
                              lnameController: lnameController,
                              emailController: emailController,
                              passwordController: passwordController,
                              phoneController: phoneController,
                            ),
                            state is SignUpLoading
                                ? const CircularProgressIndicator()
                                : ElevatedButton(
                                    onPressed: () async {
                                      try {
                                        if (!keyform.currentState!.validate()) {
                                          return;
                                        }

                                        await BlocProvider.of<SignUpCupit>(
                                                context)
                                            .signup(
                                                UserModel(
                                                    email: emailController.text,
                                                    name:
                                                        "${fnameController.text} ${lnameController.text}",
                                                    phone: phoneController.text,
                                                    password:
                                                        passwordController.text,
                                                    searchWords: [],
                                                    isMale: isMale,
                                                    image: image,
                                                    isActive: true),
                                                imageFile);
                                      } on Exception catch (e) {
                                        SnackBarWidget.showSnack(
                                            context, e.toString());
                                      }
                                    },
                                    style: ElevatedButton.styleFrom(
                                        fixedSize: const Size(500, 60),
                                        animationDuration:
                                            const Duration(seconds: 2),
                                        backgroundColor: Theme.of(context)
                                            .colorScheme
                                            .secondary),
                                    child: Text(
                                      Constants.signUp.tr(),
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 20),
                                    ),
                                  ),
                            const SizedBox(
                              height: 10,
                            ),
                            TextButton(
                                child: Text(
                                  Constants.alreadyHaveAccount.tr(),
                                  style: TextStyle(color: Colors.white),
                                ),
                                onPressed: () {
                                  GoRouter.of(context).pop();
                                }),
                            const SizedBox(
                              height: 50,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    fnameController.dispose();
    lnameController.dispose();
    phoneController.dispose();
    super.dispose();
  }
}
