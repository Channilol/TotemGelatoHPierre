import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:totem/components/back_popup.dart';
import 'package:totem/components/category_icon.dart';
import 'package:totem/components/header.dart';
import 'package:totem/models/order_item.dart';
import 'package:totem/providers/category_provider.dart';
import 'package:totem/providers/inactivity_timer_provider.dart';
import 'package:totem/providers/order_provider.dart';
import 'package:totem/screens/order_screen.dart';
import 'package:totem/services/inactivity_timer_service.dart';
import 'package:totem/services/my_colors.dart';

class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({super.key});

  @override
  ConsumerState<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen> {
  @override
  Widget build(BuildContext context) {
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
                      label: "I Gourmet",
                      icon: SvgPicture.asset("assets/images/gourmet.svg")),
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
                        label: "I Classici",
                        icon: SvgPicture.asset("assets/images/classici.svg")),
                  ]),
                ),
                SizedBox(
                  width: 140,
                  child: CategoryIcon(
                      label: "Lactore Free",
                      icon: SvgPicture.asset("assets/images/lactose-free.svg")),
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
                    "Scopri le linee e prova",
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
                        "un' ",
                        style: GoogleFonts.hankenGrotesk(
                          color: MyColors.colorText,
                          height: 0,
                          fontSize: 30.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "esperienza unica",
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
                                    "Tocca lo schermo",
                                    style: GoogleFonts.hankenGrotesk(
                                      color: MyColors.colorText,
                                      height: 0,
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    "per ordinare",
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
