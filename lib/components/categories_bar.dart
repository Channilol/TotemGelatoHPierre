import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:totem/providers/category_provider.dart';
import 'package:totem/services/utils.dart';

class CategoriesBar extends ConsumerStatefulWidget {
  const CategoriesBar({super.key});

  @override
  ConsumerState<CategoriesBar> createState() => _CategoriesBarState();
}

class _CategoriesBarState extends ConsumerState<CategoriesBar> {
  @override
  Widget build(BuildContext context) {
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
            children: [
              const Text(
                "Le nostre",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Color(0xFFC3ABA4),),
              ),
              const SizedBox(height: 10),
              Text(
                "Linee",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                    fontFamily: GoogleFonts.courgette().fontFamily,
                    color: const Color(0xFFC3ABA4)),
              ),
              Expanded(
                child: ListView(
                  children: [
                    for (int i = 0; i < Utils.categories.length; i++)
                      GestureDetector(
                        onTap: () => ref
                            .read(categoryProvider.notifier)
                            .changeCategory(i),
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 50),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Utils.categories[i].categoryId ==
                                    Utils.categories[currentCategory].categoryId
                                ? const Color(0x22C3ABA4)
                                : null,
                          ),
                          child: Column(
                            children: [
                              SvgPicture.asset(Utils.categories[i].image!, fit: BoxFit.cover,),
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
              ),
              const FaIcon(FontAwesomeIcons.universalAccess,
                  color: Color(0xFF907676)),
              const Text(
                "Accessibilità",
                style: TextStyle(
                    color: Color(0xFF907676),
                    fontSize: 12),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ));
  }
}
