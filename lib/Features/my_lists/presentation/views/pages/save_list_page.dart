import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:linkify/core/constants/constants.dart';
import 'package:linkify/core/widgets/custom_appbar.dart';

class SaveListPage extends StatelessWidget {
  const SaveListPage({super.key});
  static const String routeName = '/SaveListPage';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(title: Constants.savedList.tr()),
      body: const Center(
        child: Text('This is the Save List Page'),
      ),
    );
  }
}
