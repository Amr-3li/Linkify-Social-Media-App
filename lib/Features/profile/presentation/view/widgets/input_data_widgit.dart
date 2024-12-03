import 'package:flutter/material.dart';

// ignore: must_be_immutable
class InputDataWidgit extends StatelessWidget {
  const InputDataWidgit({
    super.key,
    required this.controller,
    this.isnumber = false,
    this.color = Colors.black,
    required this.title,
    required this.text,
  });
  final bool? isnumber;
  final String title, text;

  final TextEditingController controller;
  final Color? color;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter $title';
        }
        return null;
      },
      controller: controller,
      keyboardType: isnumber! ? TextInputType.number : TextInputType.text,
      decoration: InputDecoration(
        labelText: text,
        labelStyle: TextStyle(color: color!),
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: color!.withOpacity(0.3), width: 2),
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
