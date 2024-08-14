// ignore_for_file: file_names

import 'package:flutter/material.dart';

class BasicBagesColor extends StatelessWidget {
  const BasicBagesColor({super.key, required this.body});
  final Widget? body;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
            stops: [0.3, 0.6, 0.9],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color.fromARGB(255, 255, 255, 255),
              Color.fromARGB(255, 92, 92, 92),
              Color.fromARGB(255, 0, 0, 0),
            ]),
      ),
      child: body,
    );
  }
}
