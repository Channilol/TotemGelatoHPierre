import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:totem/components/category_icon.dart';
import 'package:totem/components/header.dart';
import 'package:totem/components/lottie_animation.dart';
import 'package:totem/providers/inactivity_timer_provider.dart';
import 'package:totem/providers/language_provider.dart';
import 'package:totem/screens/order_screen.dart';
import 'package:totem/services/my_colors.dart';
import 'package:totem/services/text.dart';
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
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: LottieAnimation(
        child: GestureDetector(
          onTap: () {
            ref.read(inactivityTimerProvider).resetInactivityTimer(context);
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const OrderScreen())).then(
              (value) {
                ref.read(inactivityTimerProvider).cancelTimer();
              },
            );
          },
          child: Column(
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
                        icon: SvgPicture.asset(
                          Utils.categories[0].image!,
                          width: ResponsiveText.title(context),
                        )),
                  ),
                  Transform.translate(
                    offset: const Offset(0, -100),
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
                          padding:
                              EdgeInsets.all(ResponsiveText.medium(context)),
                          child: SvgPicture.asset(
                            "assets/images/logo.svg",
                            width: ResponsiveText.title(context),
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      CategoryIcon(
                          label: Utils.categories[1].name,
                          icon: SvgPicture.asset(
                            Utils.categories[1].image!,
                            width: ResponsiveText.title(context),
                          )),
                    ]),
                  ),
                  SizedBox(
                    width: 140,
                    child: CategoryIcon(
                        label: Utils.categories[2].name,
                        icon: SvgPicture.asset(
                          Utils.categories[2].image!,
                          width: ResponsiveText.title(context),
                        )),
                  ),
                ],
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            language['splashScreen']['title'][0].toString(),
                            style: GoogleFonts.hankenGrotesk(
                              color: MyColors.colorText,
                              fontSize: ResponsiveText.title(context),
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
                                  fontSize: ResponsiveText.title(context),
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                language['splashScreen']['title'][2],
                                style: GoogleFonts.courgette(
                                  color: MyColors.colorText,
                                  height: 0,
                                  fontSize: ResponsiveText.title(context),
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
                    ),
                    Expanded(
                      flex: 3,
                      child: Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Image.asset(
                              'assets/images/splash_image.png',
                              fit: BoxFit.cover,
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
                                      language['splashScreen']['callToAction']
                                          [0],
                                      style: GoogleFonts.hankenGrotesk(
                                        color: MyColors.colorText,
                                        height: 0,
                                        fontSize: ResponsiveText.huge(context),
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      language['splashScreen']['callToAction']
                                          [1],
                                      style: GoogleFonts.courgette(
                                        height: 0,
                                        color: MyColors.colorText,
                                        fontSize: ResponsiveText.huge(context),
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
      ),
    );
  }
}
