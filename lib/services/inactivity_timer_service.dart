/* import 'dart:async';

import 'package:flutter/material.dart';

class InactivityTimerService {
  static Timer? _inactivityTimer;
  static Timer? _warningTimer;

  static void startInactivityTimer({
    Duration inactivityDuration = const Duration(seconds: 10),
    Duration warningDuration = const Duration(seconds: 6),
    required void Function() inactivityCallback,
    required void Function() warningCallback,
  }) {
    debugPrint("ho cliccatro");
    cancel();
    _inactivityTimer = Timer(inactivityDuration, inactivityCallback);
    _warningTimer = Timer(warningDuration, warningCallback);
  }

  static void cancel() {
    _inactivityTimer?.cancel();
    _warningTimer?.cancel();
  }
}
 */