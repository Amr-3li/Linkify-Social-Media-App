import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:linkify/core/constants/constants.dart';
import 'package:linkify/core/widgets/custom_appbar.dart';

class LoveListPage extends StatelessWidget {
  const LoveListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(title: Constants.lovedList.tr()),
      body: const Center(
        child: Text('This is the Love List Page'),
      ),
    );
  }
}
