import 'package:flutter/material.dart';
import 'package:true_gym/views/pages/app_pages/bottom_navigation.dart';
import 'package:true_gym/views/widgets/input_text.dart';
import 'package:true_gym/views/pages/register_pages/signup_page.dart';

// ignore: must_be_immutable
class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  var emailController = TextEditingController();

  var passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
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
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const BottomNavigation()));
                        },
                        style: ElevatedButton.styleFrom(
                            fixedSize: const Size(500, 60),
                            animationDuration: const Duration(seconds: 2),
                            backgroundColor:
                                const Color.fromARGB(199, 69, 69, 135)),
                        child: const Text(
                          "Login",
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SignupPage()));
                        },
                        style: ElevatedButton.styleFrom(
                          fixedSize: const Size(500, 60),
                          animationDuration: const Duration(seconds: 2),
                        ),
                        child: const Text(
                          "Register",
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                      const SizedBox(
                        height: 200,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
