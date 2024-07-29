import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:totem/components/back_popup.dart';
import 'package:totem/services/inactivity_timer_service.dart';

class InactivityTimer extends ConsumerStatefulWidget {
  final Widget child;
  const InactivityTimer({super.key, required this.child});

  @override
  ConsumerState<InactivityTimer> createState() => _InactivityTimerState();
}

class _InactivityTimerState extends ConsumerState<InactivityTimer> {
  void _goBack() {
    Navigator.popUntil(context, ModalRoute.withName("/"));
  }

  void _showWarning() {
    if (!mounted) return;
    showDialog(
      context: context,
      builder: (context) => const BackPopup(),
    ).then(
      (value) => _startTimer(),
    );
  }

  void _startTimer() =>
    InactivityTimerService.startInactivityTimer(inactivityCallback: _goBack, warningCallback: _showWarning);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _startTimer,
      onPanDown: (_) => _startTimer,
      child: widget.child,
    );
  }
}
