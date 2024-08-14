import 'package:flutter/material.dart';

// ignore: must_be_immutable
class InputTextField extends StatelessWidget {
  InputTextField({
    super.key,
    this.isPassword,
    required this.hintText,
    required this.controller,
    this.isnumber = false,
  });
  bool? isPassword, isnumber;
  String hintText;
  TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter $hintText';
        }
        return null;
      },
      controller: controller,
      obscureText: isPassword ?? false,
      keyboardType: isnumber! ? TextInputType.number : TextInputType.text,
      decoration: InputDecoration(
        labelText: hintText,
        labelStyle: const TextStyle(color: Colors.white),
        hintStyle: const TextStyle(color: Colors.white),
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
        ),
      ),
      style: const TextStyle(color: Colors.white),
    );
  }
}
