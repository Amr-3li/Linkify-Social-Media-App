import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:true_gym/Features/register/data/model/user.dart';
import 'package:true_gym/Features/register/presentation/cubit/signup/signup_cubit.dart';
import 'package:true_gym/Features/register/presentation/cubit/auth/auth_cubit.dart';
import 'package:true_gym/Features/register/presentation/cubit/user_data/user_cubit.dart';
import 'package:true_gym/Features/register/presentation/view/widgets/user_image.dart';
import 'package:true_gym/Features/register/presentation/view/widgets/user_informations.dart';

// ignore: must_be_immutable
class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  bool isMale = false;

  bool isFemale = false;

  bool isTrainer = false;

  String? image;
  File? imageFile;

  TextEditingController emailController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  TextEditingController fnameController = TextEditingController();

  TextEditingController lnameController = TextEditingController();

  TextEditingController phoneController = TextEditingController();

  TextEditingController ageController = TextEditingController();

  TextEditingController heightController = TextEditingController();

  TextEditingController weightController = TextEditingController();

  final keyform = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SignUpCupit, SignUpState>(
      listener: (context, state) {
        if (state is SignUpSuccess) {
          showSnackBar("User created successfully");
          Navigator.pop(context);
        } else if (state is SignUpError) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(state.message.toString())));
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
                      height: 40,
                    ),
                    const Text(
                      "Sign Up Page",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 55,
                          fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 40,
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
                            const SizedBox(height: 30),
                            UserImage(
                              image: (image) {
                                imageFile = image;
                              },
                            ),
                            const SizedBox(height: 20),
                            UserInformations(
                                isFemale: isFemale,
                                isMale: isMale,
                                isTrainer: isTrainer,
                                fnameController: fnameController,
                                lnameController: lnameController,
                                emailController: emailController,
                                phoneController: phoneController,
                                ageController: ageController,
                                heightController: heightController,
                                weightController: weightController,
                                passwordController: passwordController),
                            state is RegisterLoading
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
                                                    fname: fnameController.text,
                                                    lname: lnameController.text,
                                                    phone: phoneController.text,
                                                    password:
                                                        passwordController.text,
                                                    isPatient: !isTrainer,
                                                    isMale: isMale,
                                                    weight: double.parse(
                                                        weightController.text),
                                                    height: double.parse(
                                                        heightController.text),
                                                    lastActive: DateTime.now(),
                                                    image: image),
                                                imageFile!);
                                      } on Exception catch (e) {
                                        showSnackBar(e.toString());
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

  void showSnackBar(String message) {
    final snackBar = SnackBar(content: Text(message));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
