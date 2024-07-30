import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:totem/components/animated_filp_number.dart';
import 'package:totem/components/header.dart';
import 'package:totem/components/semicircle.dart';
import 'package:totem/providers/order_provider.dart';
import 'package:totem/services/my_colors.dart';
import 'package:totem/services/utils.dart';

class PaymentScreen extends ConsumerStatefulWidget {
  const PaymentScreen({super.key});

  @override
  ConsumerState<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends ConsumerState<PaymentScreen> {
  @override
  Widget build(BuildContext context) {
    final order = ref.watch(orderProvider);
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
          Semicircle(),
          const SizedBox(height: 20),
          Text(
            "Totale ordine",
            style: TextStyle(
                fontFamily: GoogleFonts.courgette().fontFamily,
                fontSize: 50,
                color: const Color(0xFFC3ABA4),
                fontWeight: FontWeight.bold),
          ),
          AnimatedFlipCounter(
            prefix: "€ ",
            fractionDigits: 2,
            value: Utils.getTotalPrice(order.rows),
            textStyle: const TextStyle(
                fontSize: 40,
                color: Color(0xFF907676),
                fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 45,
          ),
          Text(
            "Dove vuoi pagare?",
            style: const TextStyle(
                fontSize: 40,
                color: Color(0xFF907676),
                fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 15,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                children: [
                  ClipRRect(
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.4,
                      height: MediaQuery.of(context).size.width * 0.4,
                      decoration: BoxDecoration(
                        color: MyColors.colorContainer,
                        borderRadius: BorderRadius.circular(24.0),
                      ),
                      child: Image.asset(
                        'assets/images/pagamento_totem.png',
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                ],
              ),
              Column(
                children: [
                  ClipRRect(
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.4,
                      height: MediaQuery.of(context).size.width * 0.4,
                      decoration: BoxDecoration(
                        color: MyColors.colorContainer,
                        borderRadius: BorderRadius.circular(24.0),
                      ),
                      child: Image.asset(
                        'assets/images/pagamento_cassa.png',
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {},
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 10,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      FaIcon(FontAwesomeIcons.universalAccess),
                      SizedBox(
                        width: 7.5,
                      ),
                      Text(
                        "Accessibilità",
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 15,
          )
        ],
      ),
    );
  }
}
