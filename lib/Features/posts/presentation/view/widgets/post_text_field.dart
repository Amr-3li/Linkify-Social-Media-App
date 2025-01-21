import 'package:flutter/material.dart';

class PostTextField extends StatelessWidget {
  const PostTextField({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(15),
      width: double.infinity,
      height: 200,
      child: TextFormField(
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
