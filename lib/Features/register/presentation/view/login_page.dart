import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:true_gym/Features/register/presentation/cubit/auth/auth_cubit.dart';
import 'package:true_gym/core/utils/icons.dart';
import 'package:true_gym/core/utils/images.dart';
import 'package:true_gym/views/widgets/input_text.dart';

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
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(state.error.toString())));
        }
      },
      builder: (context, state) {
        return Scaffold(
          body: Container(
            decoration: const BoxDecoration(
              color: Color.fromARGB(255, 255, 255, 255),
              // image: DecorationImage(
              //   image: AssetImage(
              //     MyImages.imagesAppIcon,
              //   ),
              //   opacity: 0.9,
              // ),
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
                    const Text(
                      "Login Page",
                      style: TextStyle(
                          color: Color.fromARGB(255, 108, 108, 108),
                          fontSize: 60,
                          fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: const Color.fromARGB(190, 20, 20, 20),
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
                              hintText: "Email",
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            InputTextField(
                              controller: passwordController,
                              hintText: "password",
                              isPassword: true,
                            ),
                            Align(
                              alignment: AlignmentDirectional.centerEnd,
                              child: TextButton(
                                child: const Text(
                                  "forget password?",
                                  style: TextStyle(color: Colors.white),
                                ),
                                onPressed: () {},
                              ),
                            ),
                            state is SigninLoading
                                ? const CircularProgressIndicator()
                                : ElevatedButton(
                                    onPressed: () async {
                                      try {
                                        formKey.currentState!.validate();
                                        await BlocProvider.of<AuthCubit>(
                                                context)
                                            .signin(emailController.text.trim(),
                                                passwordController.text);
                                      } catch (e) {
                                        print(e.toString());
                                      }
                                    },
                                    style: ElevatedButton.styleFrom(
                                        fixedSize: const Size(500, 60),
                                        animationDuration:
                                            const Duration(seconds: 2),
                                        backgroundColor: const Color.fromARGB(
                                            199, 69, 69, 135)),
                                    child: const Text(
                                      "Login",
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
                              height: 20,
                            ),
                            state is SigninLoading ||
                                    state is SigninWithGoogleLoading
                                ? const SizedBox()
                                : googleButton(context),
                            const SizedBox(
                              height: 40,
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
      onDoubleTap: () async {
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
                  MyIcons.iconsGoogle,
                  width: 50,
                ),
              ),
              RichText(
                text: const TextSpan(children: [
                  TextSpan(
                      text: "Sign in with ",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  TextSpan(
                      text: "Google",
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

  ElevatedButton signupButton(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        print("prressed");
        GoRouter.of(context).push('/signupPage');
      },
      style: ElevatedButton.styleFrom(
        fixedSize: const Size(500, 60),
        animationDuration: const Duration(seconds: 2),
      ),
      child: const Text(
        "Register",
        style: TextStyle(fontSize: 20),
      ),
    );
  }
}
