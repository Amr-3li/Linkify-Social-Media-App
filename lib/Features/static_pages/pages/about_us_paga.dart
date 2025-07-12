import 'package:flutter/material.dart';
import 'package:linkify/core/widgets/custom_appbar.dart';

class AboutUsPaga extends StatelessWidget {
  const AboutUsPaga({super.key});
  static const String routeName = '/about-us';
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: CustomAppbar(
        title: 'About Us',
      ),
      body: Center(child: Text("About Us")),
    );
  }
}
