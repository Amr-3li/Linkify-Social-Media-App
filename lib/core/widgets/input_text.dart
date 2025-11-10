import 'package:flutter/material.dart';

// ignore: must_be_immutable
class InputTextField extends StatelessWidget {
  const InputTextField({
    super.key,
    this.isPassword = false,
    required this.hintText,
    required this.controller,
    this.isnumber = false,
    this.color = Colors.white,
    this.onChanged,
    this.suffixIcon,
  });
  final bool isPassword;
  final bool? isnumber;
  final String hintText;
  final TextEditingController controller;
  final Color? color;
  final void Function(String)? onChanged;
  final Widget? suffixIcon;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter $hintText';
        }
        return null;
      },
      onChanged: onChanged,
      onTapOutside: (event) => FocusScope.of(context).unfocus(),
      controller: controller,
      obscureText: isPassword,
      keyboardType: isnumber! ? TextInputType.number : TextInputType.text,
      decoration: InputDecoration(
        suffixIcon: suffixIcon,
        labelText: hintText,
        labelStyle: TextStyle(color: color!),
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: color!, width: 1),
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
