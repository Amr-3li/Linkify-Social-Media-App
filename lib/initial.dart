// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:true_gym/Features/register/data/repository/auth_repo.dart';
import 'package:true_gym/Features/register/data/web_servecies/get_it_ser.dart';
import 'package:true_gym/Features/register/presentation/cubit/auth/auth_cubit.dart';
import 'package:true_gym/Features/register/presentation/cubit/user_data/user_cubit.dart';
import 'package:true_gym/Features/home/presentation/view/home_page.dart';
import 'package:true_gym/Features/register/presentation/view/login_page.dart';

class InitialPage extends StatefulWidget {
  const InitialPage({super.key});

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
    loging = prefs!.getString('loging');
    if (loging == null) {
      GoRouter.of(context).push('/loginPage');
    } else {
      GoRouter.of(context).push('/homePage');
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
