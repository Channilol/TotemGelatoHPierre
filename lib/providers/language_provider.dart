import 'package:flutter/services.dart';
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

extension ColorExtension on String {
  Color? toColor() {
    var hexColor = replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF$hexColor";
    }
    if (hexColor.length == 8) {
      return Color(int.parse("0x$hexColor"));
    }
    return null;
  }
}
