import 'package:flutter/material.dart';
import 'package:true_gym/views/widgets/input_text.dart';

// ignore: must_be_immutable
class UserInformations extends StatefulWidget {
  UserInformations({
    super.key,
    required this.fnameController,
    required this.lnameController,
    required this.emailController,
    required this.phoneController,
    required this.ageController,
    required this.heightController,
    required this.weightController,
    required this.passwordController,
    required this.isTrainer,
    required this.isMale,
    required this.isFemale,
  });

  final TextEditingController fnameController;
  final TextEditingController lnameController;
  final TextEditingController emailController;
  final TextEditingController phoneController;
  final TextEditingController ageController;
  final TextEditingController heightController;
  final TextEditingController weightController;
  final TextEditingController passwordController;
  bool isTrainer, isMale, isFemale;

  @override
  State<UserInformations> createState() => _UserInformationsState();
}

class _UserInformationsState extends State<UserInformations> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            const Text("Iam a Trainer",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold)),
            const SizedBox(width: 20),
            Switch(
              value: widget.isTrainer,
              onChanged: (value) {
                widget.isTrainer = value;
                setState(() {});
              },
            ),
            const SizedBox(height: 20),
          ],
        ),
        const SizedBox(height: 30),
        Row(
          children: [
            Expanded(
              child: InputTextField(
                  controller: widget.fnameController, hintText: "first name"),
            ),
            const SizedBox(width: 20),
            Expanded(
              child: InputTextField(
                  controller: widget.lnameController, hintText: "last name"),
            ),
          ],
        ),
        const SizedBox(height: 30),
        InputTextField(controller: widget.emailController, hintText: "Email"),
        const SizedBox(height: 30),
        InputTextField(
            controller: widget.phoneController,
            hintText: "phone number",
            isnumber: true),
        const SizedBox(height: 30),
        widget.isTrainer
            ? const SizedBox()
            : InputTextField(
                controller: widget.ageController,
                hintText: "age",
                isnumber: true),
        widget.isTrainer ? const SizedBox() : const SizedBox(height: 30),
        widget.isTrainer
            ? const SizedBox()
            : InputTextField(
                controller: widget.heightController,
                hintText: "height",
                isnumber: true),
        widget.isTrainer ? const SizedBox() : const SizedBox(height: 30),
        widget.isTrainer
            ? const SizedBox()
            : InputTextField(
                controller: widget.weightController,
                hintText: "weight",
                isnumber: true),
        widget.isTrainer ? const SizedBox() : const SizedBox(height: 30),
        InputTextField(
            controller: widget.passwordController,
            hintText: "password",
            isPassword: true),
        const SizedBox(height: 30),
        Row(
          children: [
            Checkbox(
              value: widget.isMale,
              onChanged: (value) {
                widget.isMale = true;
                widget.isFemale = false;
                setState(() {});
              },
            ),
            const Text("Male",
                style: TextStyle(color: Colors.white, fontSize: 20)),
            const SizedBox(width: 20),
            Checkbox(
              value: widget.isFemale,
              onChanged: (value) {
                widget.isMale = false;
                widget.isFemale = true;
                setState(() {});
              },
            ),
            const Text("Female",
                style: TextStyle(color: Colors.white, fontSize: 20)),
          ],
        ),
        const SizedBox(height: 30),
      ],
    );
  }
}
