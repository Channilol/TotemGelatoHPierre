import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

//CLASSE UTIL DEI COLORI DI FRANCESCO CANNIZZO

class MyColors {
  static Color colorBackground = MyColors.colorBackground;
  static Color colorContainer = Color(0xFF000000);
  static Color colorText = Color(0xFF000000);
  static Color colorSecondary = Color(0xFF000000);
  static Future<void> initColors() async {
    final data = await rootBundle.loadString("assets/theme.json");
    final jsonData = json.decode(data) as Map<String, dynamic>;
    colorBackground = (jsonData['colors']['background'] as String).toColor()!;
    colorContainer = (jsonData['colors']['container'] as String).toColor()!;
    colorText = (jsonData['colors']['primary'] as String).toColor()!;
    colorSecondary = (jsonData['colors']['secondary'] as String).toColor()!;
  }
}

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
