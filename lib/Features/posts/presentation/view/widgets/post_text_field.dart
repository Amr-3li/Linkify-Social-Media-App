import 'package:flutter/material.dart';

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
          hintText: "write post",
          disabledBorder: InputBorder.none,
        ),
        maxLines: 30,
      ),
    );
  }
}
