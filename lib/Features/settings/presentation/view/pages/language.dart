import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:linkify/core/constants/constants.dart';
import 'package:linkify/core/services/sharedpreference_singelton.dart';
import 'package:linkify/core/widgets/custom_appbar.dart';

class LanguagePage extends StatelessWidget {
  const LanguagePage({super.key});
  static const String routeName = '/languagePage';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(title: Constants.language.tr()),
      body: Column(
        children: [
          ListTile(
            title: Text(Constants.english.tr()),
            onTap: () async {
              await context.setLocale(const Locale('en'));
              SharedPreferenceSingelton.setString('lang', 'en');
            },
          ),
          ListTile(
            title: Text(Constants.arabic.tr()),
            onTap: () async {
              await context.setLocale(const Locale('ar'));
              SharedPreferenceSingelton.setString('lang', 'ar');
            },
          ),
        ],
      ),
    );
  }
}
