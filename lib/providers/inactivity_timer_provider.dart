import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:totem/components/back_popup.dart';
import 'package:totem/models/order_item.dart';
import 'package:totem/providers/accessibility_provider.dart';
import 'package:totem/providers/order_provider.dart';

final inactivityTimerProvider = Provider<InactivityTimerNotifier>((ref) {
  return InactivityTimerNotifier(ref);
});

class InactivityTimerNotifier {
  final ProviderRef ref;
  Timer? _inactivityTimer;
  Timer? _warningTimer;
  final Duration inactivityTimerDuration;
  final Duration warningTimerDuration;

  InactivityTimerNotifier(
    this.ref, {
    this.inactivityTimerDuration = const Duration(seconds: 30),
    this.warningTimerDuration = const Duration(seconds: 25),
  });

  void startInactivityTimer(BuildContext context) {
    cancelTimer();
    _warningTimer = Timer(warningTimerDuration, () => _showWarning(context));
    _inactivityTimer = Timer(inactivityTimerDuration, () => _goBack(context));
  }

  void resetInactivityTimer(BuildContext context) {
    debugPrint('Warning dialog closed');
    startInactivityTimer(context);
  }

  _goBack(BuildContext context) {
    ref.read(orderProvider.notifier).setOrder(OrderItem(rows: []));
    ref.read(accessibilityProvider.notifier).changeAccessibility(false);
    Navigator.popUntil(context, ModalRoute.withName('/'));
  }

  void _showWarning(BuildContext context) {
    if (!context.mounted) return;
    showDialog(
      context: context,
      builder: (context) => const BackPopup(),
    ).then(
      (value) {
        resetInactivityTimer(context);
      },
    );
  }

  void cancelTimer() {
    _inactivityTimer?.cancel();
    _warningTimer?.cancel();
  }
}
