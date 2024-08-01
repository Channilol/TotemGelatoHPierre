import 'package:flutter/material.dart';
import 'package:totem/components/lottie_animation.dart';
import 'package:totem/screens/splash_screen.dart';

class AnimationScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: LottieAnimation(
      child: const SplashScreen(),
    ));
  }
}
