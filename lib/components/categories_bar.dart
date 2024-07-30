import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:totem/providers/accessibility_provider.dart';
import 'package:totem/providers/category_provider.dart';
import 'package:totem/providers/language_provider.dart';
import 'package:totem/services/my_colors.dart';
import 'package:totem/services/utils.dart';

class CategoriesBar extends ConsumerStatefulWidget {
  const CategoriesBar({super.key});

  @override
  ConsumerState<CategoriesBar> createState() => _CategoriesBarState();
}

class _CategoriesBarState extends ConsumerState<CategoriesBar> {
  @override
  Widget build(BuildContext context) {
    final isAccessibilityOn = ref.watch(accessibilityProvider);
    final language = Utils.languages[ref.watch(languageProvider)];
    final currentCategory = ref.watch(categoryProvider);
    return Container(
        decoration: const BoxDecoration(
          boxShadow: [BoxShadow(color: Color(0x22000000), blurRadius: 100)],
          borderRadius: BorderRadius.only(topRight: Radius.circular(10)),
          color: Color(0xFFF1EAE2),
        ),
        width: 90,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: isAccessibilityOn
                ? MainAxisAlignment.end
                : MainAxisAlignment.start,
            children: [
              Text(
                language['orderScreen']['sidebar_title'][0],
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Color(0xFFC3ABA4),
                ),
              ),
              const SizedBox(height: 10),
              Text(
                language['orderScreen']['sidebar_title'][1],
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                    fontFamily: GoogleFonts.courgette().fontFamily,
                    color: const Color(0xFFC3ABA4)),
              ),
              Column(
                children: [
                  for (int i = 0; i < Utils.categories.length; i++)
                    GestureDetector(
                      onTap: () =>
                          ref.read(categoryProvider.notifier).changeCategory(i),
                      child: Container(
                        padding: isAccessibilityOn
                            ? EdgeInsets.symmetric(vertical: 10)
                            : EdgeInsets.symmetric(vertical: 50),
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Utils.categories[i].categoryId ==
                                  Utils.categories[currentCategory].categoryId
                              ? Color.fromARGB(255, 255, 255, 255)
                              : null,
                        ),
                        child: Column(
                          children: [
                            SvgPicture.asset(
                              Utils.categories[i].image!,
                              fit: BoxFit.cover,
                            ),
                            Text(
                              Utils.categories[i].name,
                              style: const TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF907676)),
                            ),
                          ],
                        ),
                      ),
                    ),
                ],
              ),
              isAccessibilityOn
                  ? SizedBox(
                      height: 20,
                    )
                  : Spacer(),
              GestureDetector(
                onTap: () {
                  ref
                      .read(accessibilityProvider.notifier)
                      .changeAccessibility(isAccessibilityOn ? false : true);
                },
                child: Column(
                  children: [
                    const FaIcon(FontAwesomeIcons.universalAccess,
                        color: Color(0xFF907676)),
                    Text(
                      language['orderScreen']['accessibility_text'],
                      style: TextStyle(color: Color(0xFF907676), fontSize: 12),
                    ),
                  ],
                ),
              ),
              isAccessibilityOn ? SizedBox() : const SizedBox(height: 20),
            ],
          ),
        ));
  }
}
