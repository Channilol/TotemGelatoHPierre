import 'package:flutter/material.dart';
import 'package:totem/components/lottie_animation.dart';
import 'package:totem/screens/splash_screen.dart';

class AnimationScreen extends StatefulWidget {
  const AnimationScreen({super.key});

  @override
  State<AnimationScreen> createState() => _AnimationScreenState();
}

class _AnimationScreenState extends State<AnimationScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 4), () {
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => const SplashScreen()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: LottieAnimation());
  }
}
