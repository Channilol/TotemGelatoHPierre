import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:totem/components/animated_filp_number.dart';
import 'package:totem/components/header.dart';
import 'package:totem/components/language_popup.dart';
import 'package:totem/components/semicircle.dart';
import 'package:totem/models/order_item.dart';
import 'package:totem/providers/accessibility_provider.dart';
import 'package:totem/providers/language_provider.dart';
import 'package:totem/providers/order_provider.dart';
import 'package:totem/services/my_colors.dart';
import 'package:totem/services/text.dart';
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

    final deviceHeight = MediaQuery.of(context).size.height;
    final deviceWidth = MediaQuery.of(context).size.width;
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
                fontSize: ResponsiveText.title(context),
                color: MyColors.colorSecondary,
                fontWeight: FontWeight.bold),
          ),
          AnimatedFlipCounter(
            prefix: "€ ",
            fractionDigits: 2,
            value: Utils.getTotalPrice(order.rows),
            textStyle: TextStyle(
                fontSize: ResponsiveText.title(context),
                color: MyColors.colorText,
                fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: isAccessibility ? 10 : 45,
          ),
          Text(
            Utils.languages[languageIndex]['paymentScreen']['subtitle'],
            style: TextStyle(
                fontSize: ResponsiveText.huge(context),
                color: MyColors.colorText,
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
                  GestureDetector(
                    onTap: () {
                      ref
                          .read(orderProvider.notifier)
                          .setOrder(OrderItem(rows: []));
                      Navigator.popUntil(context, (route) => route.isFirst);
                    },
                    child: ClipRRect(
                      child: Container(
                        width: deviceWidth < deviceHeight
                            ? deviceWidth * 0.4
                            : deviceHeight * 0.4,
                        height: deviceWidth < deviceHeight
                            ? deviceWidth * 0.4
                            : deviceHeight * 0.4,
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
                  ),
                ],
              ),
              Column(
                children: [
                  GestureDetector(
                    onTap: () {
                      ref
                          .read(orderProvider.notifier)
                          .setOrder(OrderItem(rows: []));
                      Navigator.popUntil(context, (route) => route.isFirst);
                    },
                    child: ClipRRect(
                      child: Container(
                        width: deviceWidth < deviceHeight
                            ? deviceWidth * 0.4
                            : deviceHeight * 0.4,
                        height: deviceWidth < deviceHeight
                            ? deviceWidth * 0.4
                            : deviceHeight * 0.4,
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
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                isAccessibility
                    ? Expanded(
                        child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: BackButton(),
                      ))
                    : Container(),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: MyColors.colorText,
                  ),
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
                          style: TextStyle(
                            fontSize: 18,
                            color: MyColors.colorBackground,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                isAccessibility
                    ? Expanded(child: Center(child: LanguagePopup()))
                    : Container(),
              ],
            ),
          ),
          if (!isAccessibility) SizedBox(height: 15),
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
            backgroundColor: MyColors.colorBackground),
        onPressed: () => Navigator.pop(context),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Icon(
              Icons.arrow_back_ios_new_rounded,
              color: MyColors.colorText,
              size: 18,
            ),
            Text("BACK",
                style: TextStyle(
                    color: MyColors.colorText,
                    fontFamily: GoogleFonts.nunito().fontFamily,
                    fontSize: ResponsiveText.medium(context))),
          ],
        ),
      ),
    );
  }
}
