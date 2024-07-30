import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:totem/components/animated_filp_number.dart';
import 'package:totem/components/header.dart';
import 'package:totem/components/language_popup.dart';
import 'package:totem/components/semicircle.dart';
import 'package:totem/providers/accessibility_provider.dart';
import 'package:totem/providers/language_provider.dart';
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
    final isAccessibility = ref.watch(accessibilityProvider);
    final languageIndex = ref.watch(languageProvider);
    return Scaffold(
      body: Column(
        children: [
          Header(
            leading: isAccessibility ? Container() : BackButton(),
          ),
          Semicircle(),
          isAccessibility ? Expanded(child: Container()) : Container(),
          const SizedBox(height: 20),
          Text(
            Utils.languages[languageIndex]['paymentScreen']['title'],
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
            height: isAccessibility ? 10 : 45,
          ),
          Text(
            Utils.languages[languageIndex]['paymentScreen']['subtitle'],
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
          isAccessibility
              ? SizedBox(
                  height: 15,
                )
              : Spacer(),
          Container(
            padding: isAccessibility
                ? const EdgeInsets.symmetric(vertical: 10)
                : null,
            decoration: BoxDecoration(
              color: isAccessibility
                  ? MyColors.colorContainer
                  : Colors.transparent,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                isAccessibility ? BackButton() : Container(),
                ElevatedButton(
                  onPressed: () {
                    ref
                        .read(accessibilityProvider.notifier)
                        .changeAccessibility(!isAccessibility);
                  },
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 10,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        FaIcon(FontAwesomeIcons.universalAccess),
                        SizedBox(
                          width: 7.5,
                        ),
                        Text(
                          Utils.languages[languageIndex]['paymentScreen']
                              ['button'],
                          style: const TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                isAccessibility ? LanguagePopup() : Container(),
              ],
            ),
          ),
          isAccessibility
              ? Container()
              : SizedBox(
                  height: 15,
                ),
        ],
      ),
    );
  }
}

class BackButton extends StatelessWidget {
  const BackButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
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
    );
  }
}
