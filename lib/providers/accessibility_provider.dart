import 'package:flutter_riverpod/flutter_riverpod.dart';

class AccessibilityProvider extends StateNotifier<bool> {
  AccessibilityProvider() : super(false);

  void changeAccessibility(bool newParam) => state = newParam;
}

final accessibilityProvider =
    StateNotifierProvider<AccessibilityProvider, bool>((ref) {
  return AccessibilityProvider();
});
