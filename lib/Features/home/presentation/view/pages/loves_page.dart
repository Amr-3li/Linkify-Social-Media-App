import 'package:flutter/material.dart';
import 'package:linkify/Features/home/presentation/view/widgets/lovers_body.dart';
import 'package:linkify/core/constants/constants.dart';

class LovesPage extends StatelessWidget {
  const LovesPage({super.key});
  static const String routeName = '/lovesPage';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(Constants.lovers,
            style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 20)),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(10),
          ),
        ),
      ),
      body: const LoversBody(),
    );
  }
}
