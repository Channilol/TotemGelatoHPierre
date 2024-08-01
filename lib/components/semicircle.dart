import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:totem/components/language_popup.dart';
import 'package:totem/providers/accessibility_provider.dart';
import 'package:totem/services/my_colors.dart';
import 'package:totem/services/text.dart';

class Semicircle extends ConsumerWidget {
  const Semicircle({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isAccessibility = ref.watch(accessibilityProvider);
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Spacer(),
        Transform.translate(
          offset: Offset(0, -height * 0.08),
          child: Column(children: [
            Container(
              width: width > height
                  ? MediaQuery.of(context).size.height * 0.2
                  : MediaQuery.of(context).size.width * 0.2,
              height: width > height
                  ? MediaQuery.of(context).size.height * 0.2
                  : MediaQuery.of(context).size.width * 0.2,
              decoration: BoxDecoration(
                color: MyColors.colorContainer,
                borderRadius: BorderRadius.vertical(
                  bottom: Radius.circular(500),
                  top: Radius.circular(500),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: SvgPicture.asset(
                  "assets/images/logo.svg",
                  width: ResponsiveText.title(context),
                  fit: BoxFit.contain,
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
