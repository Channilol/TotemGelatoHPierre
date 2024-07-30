import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

class Semicircle extends StatelessWidget {
  const Semicircle({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
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
              Text(
                "English",
                style: TextStyle(
                    fontFamily: GoogleFonts.courgette().fontFamily,
                    fontSize: 20,
                    color: const Color(0xFFC3ABA4)),
              ),
              const SizedBox(width: 10),
              const FaIcon(FontAwesomeIcons.flagUsa),
            ],
          ),
        ))
      ],
    );
  }
}
