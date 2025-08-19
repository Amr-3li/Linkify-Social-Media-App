import 'package:flutter/material.dart';
import 'package:linkify/core/constants/animation.dart';
import 'package:lottie/lottie.dart';

class DisconnectedPage extends StatelessWidget {
  const DisconnectedPage({super.key});
  static const String routeName = '/disconnectPage';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Lottie.asset(MyAnimation.animationsDisconnected),
      ),
    );
  }
}
