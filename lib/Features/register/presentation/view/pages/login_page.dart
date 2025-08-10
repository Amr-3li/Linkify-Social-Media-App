import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:linkify/Features/register/presentation/cubit/auth/auth_cubit.dart';
import 'package:linkify/core/constants/constants.dart';
import 'package:linkify/core/constants/icons.dart';
import 'package:linkify/core/widgets/input_text.dart';
import 'package:linkify/core/widgets/snack_bar_widget.dart';

// ignore: must_be_immutable
class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController emailController = TextEditingController();

    TextEditingController passwordController = TextEditingController();
    final formKey = GlobalKey<FormState>();

    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is SigninSuccess || state is SigninWithGoogleSuccess) {
          GoRouter.of(context).push('/initialPage');
        } else if (state is SigninFailed) {
          SnackBarWidget.showSnack(context, state.error);
        } else if (state is ResetPasswordSuccess) {
          SnackBarWidget.showSnack(
              context, Constants.passwordResetsSuccessfully);
        } else if (state is ResetPasswordfaild) {
          SnackBarWidget.showSnack(context, Constants.resetPasswordFaild);
        }
      },
      builder: (context, state) {
        return Scaffold(
          body: Container(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.background,
            ),
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
                      Constants.loginPage,
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.secondary,
                          fontSize: 50,
                          fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 10),
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Theme.of(context).colorScheme.tertiary,
                      ),
                      child: Form(
                        key: formKey,
                        child: Column(
                          children: [
                            const SizedBox(
                              height: 90,
                            ),
                            InputTextField(
                              controller: emailController,
                              hintText: Constants.email,
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            InputTextField(
                              controller: passwordController,
                              hintText: Constants.password,
                              isPassword: true,
                            ),
                            Align(
                              alignment: AlignmentDirectional.centerEnd,
                              child: TextButton(
                                child: const Text(
                                  Constants.forgetPassword,
                                  style: TextStyle(color: Colors.white),
                                ),
                                onPressed: () {
                                  GoRouter.of(context).push("/forgotPassword");
                                },
                              ),
                            ),
                            state is SigninLoading
                                ? const CircularProgressIndicator()
                                : ElevatedButton(
                                    onPressed: () async {
                                      try {
                                        if (!formKey.currentState!.validate()) {
                                          return;
                                        }
                                        await BlocProvider.of<AuthCubit>(
                                                context)
                                            .signin(emailController.text.trim(),
                                                passwordController.text);
                                      } catch (e) {
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
                                    child: const Text(
                                      Constants.login,
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 20),
                                    ),
                                  ),
                            const SizedBox(
                              height: 10,
                            ),
                            state is SigninLoading ||
                                    state is SigninWithGoogleLoading
                                ? const SizedBox()
                                : signupButton(context),
                            const SizedBox(
                              height: 10,
                            ),
                            state is SigninLoading ||
                                    state is SigninWithGoogleLoading
                                ? const SizedBox()
                                : googleButton(context),
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

  GestureDetector googleButton(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        await BlocProvider.of<AuthCubit>(context).signInWithGoogle();
      },
      child: Container(
          decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(
                Radius.circular(50),
              ),
              color: const Color.fromARGB(135, 143, 143, 143),
              border: Border.all(color: Colors.white)),
          child: Row(
            children: [
              const Spacer(),
              Padding(
                padding: const EdgeInsets.all(10),
                child: Image.asset(
                  MyIcons.iconsGoogle2702602,
                  width: 50,
                ),
              ),
              RichText(
                text: const TextSpan(children: [
                  TextSpan(
                      text: Constants.signInWith,
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  TextSpan(
                      text: Constants.google,
                      style: TextStyle(
                          color: Colors.green,
                          fontSize: 20,
                          fontWeight: FontWeight.bold))
                ]),
              ),
              const Spacer()
            ],
          )),
    );
  }

  TextButton signupButton(BuildContext context) {
    return TextButton(
      child: const Text(
        Constants.dontHaveAccount,
        style: TextStyle(color: Colors.white),
      ),
      onPressed: () {
        GoRouter.of(context).push('/signupPage');
      },
    );
  }
}
