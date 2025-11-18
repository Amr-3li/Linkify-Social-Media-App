// ignore_for_file: use_build_context_synchronously
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:linkify/Features/splash_screan/widgets/splash_body.dart';
import 'package:linkify/core/exports/app_router.dart';
import 'package:linkify/core/services/sharedpreference_singelton.dart';

class SplashScrean extends StatefulWidget {
  const SplashScrean({super.key});

  @override
  State<SplashScrean> createState() => _SplashScreanState();
}

class _SplashScreanState extends State<SplashScrean> {
  double opacity = 0.0;
  @override
  void initState() {
    super.initState();
    Future.delayed(
      const Duration(seconds: 1),
      () {
        setState(() {
          opacity = 1.0;
        });
      },
    );
    Future.delayed(
      const Duration(seconds: 5),
      () async {
        await context.setLocale(
            Locale(SharedPreferenceSingelton.getString('lang') ?? "en"));
        if (SharedPreferenceSingelton.getString('uid') != null) {
          GoRouter.of(context).pushReplacement(NavigationPage.routeName);
        } else {
          GoRouter.of(context).pushReplacement(LoginPage.routeName);
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SplashBody(opacity: opacity),
    );
  }
}
