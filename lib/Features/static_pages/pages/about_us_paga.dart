import 'package:flutter/material.dart';
import 'package:linkify/core/constants/constants.dart';
import 'package:linkify/core/widgets/custom_appbar.dart';

class AboutUsPaga extends StatelessWidget {
  const AboutUsPaga({super.key});
  static const String routeName = '/about-us';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(
        title: Constants.aboutUs,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SelectableText(
          Constants.aboutUsText,
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
