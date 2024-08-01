import 'dart:math';

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class LottieAnimation extends StatelessWidget {
  final Widget child;
  final Duration duration;
  final String animationPath;
  const LottieAnimation(
      {super.key,
      this.child = const SizedBox(),
      this.duration = const Duration(seconds: 5),
      this.animationPath = "assets/images/gelato.json"});

  @override
  Widget build(BuildContext context) {
    final size = min(
        MediaQuery.of(context).size.width, MediaQuery.of(context).size.height);
    return FutureBuilder(
        future: Future.delayed(duration, () => true),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
                child: Lottie.asset(
              animationPath,
              fit: BoxFit.cover,
              height: size,
              width: size,
            ));
          }
          return child;
        });
  }
}
