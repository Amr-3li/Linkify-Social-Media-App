// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

class InitialPage extends StatefulWidget {
  const InitialPage({super.key});
  static const String routeName = '/initialPage';
  @override
  State<InitialPage> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<InitialPage> {
  SharedPreferences? prefs;
  String? loging;
  @override
  void initState() {
    super.initState();
    getState();
  }

  getState() async {
    prefs = await SharedPreferences.getInstance();
    loging = prefs!.getString('uid');
    if (loging == null) {
      GoRouter.of(context).pushReplacement('/loginPage');
    } else {
      GoRouter.of(context).pushReplacement('/homePage');
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: CircularProgressIndicator(
          color: Colors.white,
        ),
      ),
    );
  }
}
