import 'package:flutter/material.dart';
import 'package:linkify/core/constants/constants.dart';

class PostTextField extends StatelessWidget {
  const PostTextField({super.key, required this.controller});
  final TextEditingController controller;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(15),
      width: double.infinity,
      height: 200,
      child: TextFormField(
        controller: controller,
        style: const TextStyle(fontSize: 20),
        decoration: const InputDecoration(
          hintText: Constants.whatInYourMind,
          disabledBorder: InputBorder.none,
        ),
        maxLines: 30,
      ),
    );
  }
}
