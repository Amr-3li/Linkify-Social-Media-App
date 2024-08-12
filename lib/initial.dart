// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:true_gym/bloc/cubit/auth/auth_cubit.dart';
import 'package:true_gym/views/pages/app_pages/home_page.dart';
import 'package:true_gym/views/pages/register_pages/login_page.dart';

class InitialPage extends StatefulWidget {
  const InitialPage({super.key});

  @override
  State<InitialPage> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<InitialPage> {
  SharedPreferences? prefs;
  String? id;
  @override
  void initState() {
    super.initState();
    getState();
  }

  getState() async {
    prefs = await SharedPreferences.getInstance();
    id = prefs!.getString('id');
    if (id == null) {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => BlocProvider(
                    create: (context) => AuthCubit(),
                    child: const LoginPage(),
                  )));
    } else {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => BlocProvider(
                    create: (context) => AuthCubit(),
                    child: const HomePage(),
                  )));
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
