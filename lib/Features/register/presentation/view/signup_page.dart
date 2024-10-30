import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:true_gym/Features/register/presentation/cubit/auth/auth_cubit.dart';
import 'package:true_gym/views/widgets/input_text.dart';

// ignore: must_be_immutable
class SignupPage extends StatelessWidget {
  SignupPage({super.key});

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  final keyform = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is RegisterSuccess) {
          Navigator.pop(context);
        } else if (state is RegisterFailed) {
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
                      "Sign Up Page",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 55,
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
                        key: keyform,
                        child: Column(
                          children: [
                            const SizedBox(
                              height: 90,
                            ),
                            InputTextField(
                              controller: nameController,
                              hintText: "name",
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            InputTextField(
                              controller: emailController,
                              hintText: "Email",
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            InputTextField(
                              controller: phoneController,
                              hintText: "phone number",
                              isnumber: true,
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            InputTextField(
                              controller: passwordController,
                              hintText: "password",
                              isPassword: true,
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            state is RegisterLoading
                                ? const CircularProgressIndicator()
                                : ElevatedButton(
                                    onPressed: () async {
                                      try {
                                        if (!keyform.currentState!.validate()) {
                                          return;
                                        }
                                        await BlocProvider.of<AuthCubit>(
                                                context)
                                            .register(
                                                nameController.text,
                                                emailController.text.trim(),
                                                phoneController.text,
                                                passwordController.text);

                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          const SnackBar(
                                            content: Text(
                                                "user created successfully"),
                                          ),
                                        );
                                      } on Exception catch (e) {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(SnackBar(
                                          content: Text(e.toString()),
                                        ));
                                      }
                                    },
                                    style: ElevatedButton.styleFrom(
                                        fixedSize: const Size(500, 60),
                                        animationDuration:
                                            const Duration(seconds: 2),
                                        backgroundColor: const Color.fromARGB(
                                            199, 69, 69, 135)),
                                    child: const Text(
                                      "Sign Up",
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 20),
                                    ),
                                  ),
                            const SizedBox(
                              height: 10,
                            ),
                            TextButton(
                                child: const Text(
                                  "Already have an account?",
                                  style: TextStyle(color: Colors.white),
                                ),
                                onPressed: () {
                                  Navigator.pop(context);
                                }),
                            const SizedBox(
                              height: 200,
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
}
