import 'package:flutter_riverpod/flutter_riverpod.dart';

class LanguageProvider extends StateNotifier<int> {
  LanguageProvider() : super(0);

  void setLanguage(int language) {
    state = language;
  }
}

final languageProvider = StateNotifierProvider<LanguageProvider, int>((ref) {
  return LanguageProvider();
});
