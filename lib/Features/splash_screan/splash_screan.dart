// ignore_for_file: use_build_context_synchronously
import 'package:flutter/material.dart';
import 'package:linkify/Features/splash_screan/widgets/splash_body.dart';
import 'package:linkify/core/exports/app_router.dart';

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
      () {
        GoRouter.of(context).pushReplacement(InitialPage.routeName);
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
