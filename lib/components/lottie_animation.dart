import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class LottieAnimation extends StatelessWidget {
  final Widget child;
  final Duration duration;
  final String animationPath;
  const LottieAnimation(
      {super.key,
      required this.child,
      this.duration = const Duration(seconds: 5),
      this.animationPath = "assets/images/gelato.json"});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: Future.delayed(duration, () => true),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
                child: Lottie.asset(
              animationPath,
              fit: BoxFit.cover,
              height: MediaQuery.of(context).size.width,
              width: MediaQuery.of(context).size.width,
            ));
          }
          return child;
        });
  }
}
