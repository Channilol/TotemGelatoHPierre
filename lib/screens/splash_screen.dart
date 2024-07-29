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
            Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Scopri le linee e prova",
                    style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF907676)),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const Text("un'",
                          style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF907676))),
                      Text(
                        "esperienza unica",
                        style: TextStyle(
                            decoration: TextDecoration.underline,
                            decorationThickness: 1,
                            fontSize: 35,
                            fontWeight: FontWeight.bold,
                            color: const Color(0xFF907676),
                            fontFamily: GoogleFonts.courgette().fontFamily),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Expanded(
                child: Stack(
              children: [
                Center(
                  child: Image.asset(
                    'assets/images/gelato.png',
                    fit: BoxFit.cover,
                    width: double.infinity,
                    height: double.infinity,
                  ),
                ),
                Positioned(
                  right: MediaQuery.of(context).size.width * .05,
                  top: MediaQuery.of(context).size.height * .10,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text(
                        'Tocca lo schermo',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF907676),
                        ),
                      ),
                      Text(
                        'per ordinare',
                        style: TextStyle(
                          fontSize: 30,
                          decoration: TextDecoration.underline,
                          fontFamily: GoogleFonts.courgette().fontFamily,
                          fontWeight: FontWeight.bold,
                          color: const Color(0xFF907676),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ))
          ],
        ),
      ),
    );
  }
}
