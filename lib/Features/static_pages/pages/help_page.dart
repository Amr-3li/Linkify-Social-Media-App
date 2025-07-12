import 'package:flutter/material.dart';
import 'package:linkify/core/constants/constants.dart';
import 'package:linkify/core/widgets/custom_appbar.dart';

class HelpPage extends StatelessWidget {
  const HelpPage({super.key});
  static const String routeName = '/help';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(title: Constants.help),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SelectableText(
          Constants.helpText,
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
