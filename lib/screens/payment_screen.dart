import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:totem/components/header.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({super.key});

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Header(
            leading: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: FilledButton(
                style: FilledButton.styleFrom(
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(5),
                            bottomRight: Radius.circular(20),
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(5))),
                    backgroundColor: Colors.white),
                onPressed: () => Navigator.pop(context),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    const Icon(
                      Icons.arrow_back_ios_new_rounded,
                      color: Color(0xFF907676),
                      size: 18,
                    ),
                    Text("BACK",
                        style: TextStyle(
                            color: const Color(0xFF907676),
                            fontFamily: GoogleFonts.nunito().fontFamily,
                            fontSize: 14))
                  ],
                ),
              ),
            ),
          ),
          Row(
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
                              bottom: Radius.circular(500)))),
                ]),
              ),
              const Spacer()
            ],
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
