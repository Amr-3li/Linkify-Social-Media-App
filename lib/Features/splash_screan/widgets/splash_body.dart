import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class SplashBody extends StatelessWidget {
  const SplashBody({
    super.key,
    required this.opacity,
  });

  final double opacity;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Spacer(),
        SizedBox(
            height: MediaQuery.of(context).size.width,
            width: double.infinity,
            child: LottieBuilder.asset(
              "assets/animations/dash_animation.json",
              fit: BoxFit.fill,
            )),
        AnimatedOpacity(
          opacity: opacity,
          duration: const Duration(milliseconds: 2000),
          curve: Curves.easeInCirc,
          child: Text(
            "Welcome",
            style: TextStyle(
              fontSize: MediaQuery.of(context).size.height * 0.05,
              color: const Color(0xff00D2C1),
              fontWeight: FontWeight.w900,
            ),
          ),
        ),
        const Spacer()
      ],
    );
  }
}
