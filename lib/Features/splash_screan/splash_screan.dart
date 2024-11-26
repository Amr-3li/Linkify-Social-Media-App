// ignore_for_file: use_build_context_synchronously
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:true_gym/Features/splash_screan/widgets/splash_body.dart';

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
      const Duration(seconds: 6),
      () {
        GoRouter.of(context).push('/initialPage');
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
