import 'package:flutter/material.dart';

// ignore: must_be_immutable
class InputTextField extends StatelessWidget {
  const InputTextField({
    super.key,
    this.isPassword,
    required this.hintText,
    required this.controller,
    this.isnumber = false,
    this.color = Colors.white,
  });
  final bool? isPassword, isnumber;
  final String hintText;
  final TextEditingController controller;
  final Color? color;
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
        labelStyle: TextStyle(color: color!),
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: color!.withOpacity(0.2), width: 1),
          borderRadius: BorderRadius.circular(20),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: color!, width: 1),
          borderRadius: BorderRadius.circular(20),
        ),
      ),
      style: TextStyle(color: color!),
    );
  }
}
