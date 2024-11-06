import 'package:flutter/material.dart';
import 'package:true_gym/views/widgets/input_text.dart';

class UserInformations extends StatelessWidget {
  const UserInformations({
    super.key,
    required this.fnameController,
    required this.lnameController,
    required this.emailController,
    required this.phoneController,
    required this.ageController,
    required this.heightController,
    required this.weightController,
    required this.passwordController,
  });

  final TextEditingController fnameController;
  final TextEditingController lnameController;
  final TextEditingController emailController;
  final TextEditingController phoneController;
  final TextEditingController ageController;
  final TextEditingController heightController;
  final TextEditingController weightController;
  final TextEditingController passwordController;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 20),
        Row(
          children: [
            Expanded(
              child: InputTextField(
                  controller: fnameController, hintText: "first name"),
            ),
            const SizedBox(width: 20),
            Expanded(
              child: InputTextField(
                  controller: lnameController, hintText: "last name"),
            ),
          ],
        ),
        const SizedBox(height: 30),
        InputTextField(controller: emailController, hintText: "Email"),
        const SizedBox(height: 30),
        InputTextField(
            controller: phoneController,
            hintText: "phone number",
            isnumber: true),
        const SizedBox(height: 30),
        InputTextField(
            controller: ageController, hintText: "age", isnumber: true),
        const SizedBox(height: 30),
        InputTextField(
            controller: heightController, hintText: "height", isnumber: true),
        const SizedBox(height: 30),
        InputTextField(
            controller: weightController, hintText: "weight", isnumber: true),
        const SizedBox(height: 30),
        InputTextField(
            controller: passwordController,
            hintText: "password",
            isPassword: true),
        const SizedBox(height: 30)
      ],
    );
  }
}
