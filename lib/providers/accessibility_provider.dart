import 'package:flutter_riverpod/flutter_riverpod.dart';

class AccessibilityProvider extends StateNotifier<bool> {
  AccessibilityProvider() : super(false);

  void changeCategory(bool newParam) => state = newParam;
}

final accessbilityProvider =
    StateNotifierProvider<AccessibilityProvider, bool>((ref) {
  return AccessibilityProvider();
});
