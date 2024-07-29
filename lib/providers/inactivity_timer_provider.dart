import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';

class InactivityTimerModel {
  final Timer? inactivityTimer;
  final Timer? warningTimer;
  InactivityTimerModel({this.inactivityTimer, this.warningTimer});
}

class InactivityTimerProvider extends StateNotifier<InactivityTimerModel> {
  InactivityTimerProvider() : super(InactivityTimerModel());

  void startInactivityTimer({
    Duration inactivityDuration = const Duration(seconds: 10),
    Duration warningDuration = const Duration(seconds: 6),
    required void Function() inactivityCallback,
    required void Function() warningCallback,
  }) {
    final inactivityTimer = InactivityTimerModel(
        inactivityTimer: Timer(inactivityDuration, inactivityCallback),
        warningTimer: Timer(warningDuration, warningCallback));

    state = inactivityTimer;
  }

  void resetTimer() {
    state.inactivityTimer?.cancel();
    state.warningTimer?.cancel();
  }
}

final inactivityTimerProvider =
    StateNotifierProvider<InactivityTimerProvider, InactivityTimerModel?>(
        (ref) {
  return InactivityTimerProvider();
});
