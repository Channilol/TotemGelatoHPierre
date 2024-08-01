import 'package:flutter_riverpod/flutter_riverpod.dart';

class PasswordProvider extends StateNotifier<String> {
  PasswordProvider() : super("");

  void changePassword(String newParam) => state += newParam;

  void deletePassword() => state = state.substring(0, state.length - 1);
}

final passwordProvider = StateNotifierProvider<PasswordProvider, String>((ref) {
  return PasswordProvider();
});
