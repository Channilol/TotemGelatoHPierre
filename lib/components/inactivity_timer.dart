import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:totem/providers/inactivity_timer_provider.dart';

class InactivityTimer extends ConsumerWidget {
  final Widget child;
  const InactivityTimer({super.key, required this.child});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final timerNotifier = ref.read(inactivityTimerProvider);

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () => timerNotifier.resetInactivityTimer(context),
      onPanDown: (_) => timerNotifier.resetInactivityTimer(context),
      child: child,
    );
  }
}
