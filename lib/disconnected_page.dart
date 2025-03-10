import 'package:flutter/material.dart';
import 'package:linkify/core/constants/animation.dart';
import 'package:lottie/lottie.dart';

class DisconnectedPage extends StatelessWidget {
  const DisconnectedPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Lottie.asset(MyAnimation.animationsDisconnected),
      ),
    );
  }
}
