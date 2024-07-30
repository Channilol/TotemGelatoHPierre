import 'dart:convert';
import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:json_theme/json_theme.dart';
import 'package:totem/screens/splash_screen.dart';
import 'package:totem/services/utils.dart';

late ThemeData theme;
// C3ABA4
void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final stringa = await rootBundle.loadString("assets/appainter_theme.json");
  final jsonCode = jsonDecode(stringa);
  theme = ThemeDecoder.decodeThemeData(jsonCode) ?? ThemeData();

  await Utils.init();

  runApp(const ProviderScope(child: TotemApp()));
}

class TotemApp extends ConsumerWidget {
  const TotemApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      scrollBehavior: kIsWeb
          ? MaterialScrollBehavior().copyWith(
              dragDevices: {
                PointerDeviceKind.mouse,
                PointerDeviceKind.touch,
                PointerDeviceKind.stylus,
                PointerDeviceKind.unknown
              },
            )
          : null,
      title: 'Totem app',
      theme: theme,
      home: const SplashScreen(),
    );
  }
}
