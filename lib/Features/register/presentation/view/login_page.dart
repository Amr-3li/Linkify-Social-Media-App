import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:true_gym/Features/register/presentation/cubit/auth/auth_cubit.dart';
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
        if (state is SigninSuccess) {
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
                image: DecorationImage(
                    image: AssetImage("assets/images/gym login.jpg"),
                    fit: BoxFit.cover)),
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
                      height: 200,
                    ),
                    const Text(
                      "Login Page",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 60,
                          fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 100,
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
                            const SizedBox(
                              height: 30,
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
                            state is SigninLoading
                                ? const SizedBox()
                                : signupButton(context),
                            const SizedBox(
                              height: 200,
                            ),
                            ElevatedButton(
                                onPressed: () {},
                                child: Row(
                                  children: [Image.asset("")],
                                ))
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

  ElevatedButton signupButton(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
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
