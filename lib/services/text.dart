import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ResponsiveText {
  static List<double> _tiny = [];
  static List<double> _small = [];
  static List<double> _medium = [];
  static List<double> _large = [];
  static List<double> _huge = [];

  static Future<void> init() async {
    final data = await rootBundle.loadString("assets/theme.json");
    final jsonData =
        (jsonDecode(data) as Map<String, dynamic>)['texts']['size'];

    _tiny = (jsonData['tiny'] as List<dynamic>)
        .map((e) => double.parse(e.toString()))
        .toList();
    _small = (jsonData['small'] as List<dynamic>)
        .map((e) => double.parse(e.toString()))
        .toList();
    _medium = (jsonData['medium'] as List<dynamic>)
        .map((e) => double.parse(e.toString()))
        .toList();
    _large = (jsonData['large'] as List<dynamic>)
        .map((e) => double.parse(e.toString()))
        .toList();
    _huge = (jsonData['huge'] as List<dynamic>)
        .map((e) => double.parse(e.toString()))
        .toList();
  }

  static double tiny(BuildContext context) {
    return _tiny[_index(context)];
  }

  static double small(BuildContext context) {
    return _small[_index(context)];
  }

  static double medium(BuildContext context) {
    return _medium[_index(context)];
  }

  static double large(BuildContext context) {
    return _large[_index(context)];
  }

  static double huge(BuildContext context) {
    return _huge[_index(context)];
  }

  static int _index(BuildContext context) {
    final size = MediaQuery.of(context).size.width;
    if (size < 600) {
      return 0;
    } else if (size < 900) {
      return 1;
    } else if (size < 1200) {
      return 2;
    } else {
      return 3;
    }
  }
}
