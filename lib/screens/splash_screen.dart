import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:totem/components/category_icon.dart';
import 'package:totem/components/header.dart';
import 'package:totem/providers/inactivity_timer_provider.dart';
import 'package:totem/providers/language_provider.dart';
import 'package:totem/screens/order_screen.dart';
import 'package:totem/services/my_colors.dart';
import 'package:totem/services/utils.dart';

class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({super.key});

  @override
  ConsumerState<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    var language = Utils.languages[ref.read(languageProvider)];
    if (language.isEmpty) {
      language = ref.watch(languageProvider);
    }
    return GestureDetector(
      onTap: () {
        ref.read(inactivityTimerProvider).resetInactivityTimer(context);
        Navigator.push(context,
                MaterialPageRoute(builder: (context) => const OrderScreen()))
            .then((value) {
          ref.read(inactivityTimerProvider).cancelTimer();
        });
      },
      child: Scaffold(
        body: Column(
          children: [
            const Header(),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 140,
                  child: CategoryIcon(
                      label: Utils.categories[0].name,
                      icon: SvgPicture.asset(Utils.categories[1].image!)),
                ),
                Transform.translate(
                  offset: const Offset(0, -10),
                  child: Column(children: [
                    Container(
                        width: 120,
                        height: 60,
                        decoration: const BoxDecoration(
                            color: Color(0xFFF1EAE2),
                            borderRadius: BorderRadius.vertical(
                                bottom: Radius.circular(500)))),
                    const SizedBox(height: 10),
                    CategoryIcon(
                        label: Utils.categories[1].name,
                        icon: SvgPicture.asset(Utils.categories[1].image!)),
                  ]),
                ),
                SizedBox(
                  width: 140,
                  child: CategoryIcon(
                      label: Utils.categories[2].name,
                      icon: SvgPicture.asset(
                        Utils.categories[2].image!,
                      )),
                ),
              ],
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    language['splashScreen']['title'][0].toString(),
                    style: GoogleFonts.hankenGrotesk(
                      color: MyColors.colorText,
                      fontSize: 26.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        language['splashScreen']['title'][1],
                        style: GoogleFonts.hankenGrotesk(
                          color: MyColors.colorText,
                          height: 0,
                          fontSize: 30.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        language['splashScreen']['title'][2],
                        style: GoogleFonts.courgette(
                          color: MyColors.colorText,
                          height: 0,
                          fontSize: 30.0,
                          fontWeight: FontWeight.bold,
                          decoration: TextDecoration.underline,
                          decorationColor: MyColors.colorText,
                          decorationThickness: 1.0,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Expanded(
                    child: Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            'assets/images/splash_image.png',
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.15,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    language['splashScreen']['callToAction'][0],
                                    style: GoogleFonts.hankenGrotesk(
                                      color: MyColors.colorText,
                                      height: 0,
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    language['splashScreen']['callToAction'][0],
                                    style: GoogleFonts.courgette(
                                      height: 0,
                                      color: MyColors.colorText,
                                      fontSize: 27.0,
                                      fontWeight: FontWeight.bold,
                                      decoration: TextDecoration.underline,
                                      decorationColor: MyColors.colorText,
                                      decorationThickness: 1.0,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
