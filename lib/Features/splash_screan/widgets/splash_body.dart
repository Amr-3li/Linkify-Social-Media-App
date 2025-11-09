import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:linkify/core/constants/animation.dart';
import 'package:linkify/core/constants/constants.dart';
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
              MyAnimation.animationsDashAnimation,
              fit: BoxFit.fill,
            )),
        AnimatedOpacity(
          opacity: opacity,
          duration: const Duration(milliseconds: 2000),
          curve: Curves.easeInCirc,
          child: Text(
            Constants.welcome.tr(),
            style: TextStyle(
              fontSize: MediaQuery.of(context).size.height * 0.05,
              color: Theme.of(context).colorScheme.primary,
              fontWeight: FontWeight.w900,
            ),
          ),
        ),
        const Spacer()
      ],
    );
  }
}
