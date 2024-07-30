import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:totem/components/language_popup.dart';
import 'package:totem/providers/accessibility_provider.dart';

class Semicircle extends ConsumerWidget {
  const Semicircle({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isAccessibility = ref.watch(accessibilityProvider);
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Spacer(),
        Transform.translate(
          offset: const Offset(0, -10),
          child: Column(children: [
            Container(
              width: 120,
              height: 60,
              decoration: const BoxDecoration(
                color: Color(0xFFF1EAE2),
                borderRadius: BorderRadius.vertical(
                  bottom: Radius.circular(500),
                ),
              ),
            ),
          ]),
        ),
        Expanded(
            child: Padding(
          padding: const EdgeInsets.all(10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              isAccessibility ? Container() : LanguagePopup(),
            ],
          ),
        ))
      ],
    );
  }
}
