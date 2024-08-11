import 'package:flutter/material.dart';

// ignore: must_be_immutable
class InputTextField extends StatelessWidget {
   InputTextField({super.key, this.isPassword,required this.hintText,required this.controller,});
  bool ? isPassword;
  String hintText;
  TextEditingController controller;
  @override
  Widget build(BuildContext context) {
    return  TextField(
      controller: controller,
      obscureText: isPassword ?? false,
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