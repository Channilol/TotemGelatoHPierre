import 'dart:convert';
import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:json_theme/json_theme.dart';
import 'package:totem/screens/splash_screen.dart';
import 'package:totem/services/my_colors.dart';
import 'package:totem/services/text.dart';
import 'package:totem/services/utils.dart';
import 'package:window_manager/window_manager.dart';

late ThemeData theme;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
  final stringa = await rootBundle.loadString("assets/appainter_theme.json");
  final jsonCode = jsonDecode(stringa);
  theme = ThemeDecoder.decodeThemeData(jsonCode) ?? ThemeData();
  // await FullScreen.enterFullScreen(FullScreenMode.EMERSIVE_STICKY);
  await WindowManager.instance.setFullScreen(true);
  await WindowManager.instance.setClosable(false);
  await Utils.init();
  await MyColors.initColors();
  await ResponsiveText.init();

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
