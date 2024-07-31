import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:totem/components/animated_filp_number.dart';
import 'package:totem/components/back_button.dart';
import 'package:totem/components/clear_button.dart';
import 'package:totem/components/clear_order_popup.dart';
import 'package:totem/components/header.dart';
import 'package:totem/components/inactivity_timer.dart';
import 'package:totem/components/language_popup.dart';
import 'package:totem/components/order_recap_item.dart';
import 'package:totem/components/product_card.dart';
import 'package:totem/components/semicircle.dart';
import 'package:totem/models/order_item.dart';
import 'package:totem/providers/accessibility_provider.dart';
import 'package:totem/providers/language_provider.dart';
import 'package:totem/providers/order_provider.dart';
import 'package:totem/screens/payment_screen.dart';
import 'package:totem/services/my_colors.dart';
import 'package:totem/services/text.dart';
import 'package:totem/services/utils.dart';

class OrderRecapScreen extends ConsumerWidget {
  const OrderRecapScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final order = ref.watch(orderProvider);
    final accessibility = ref.watch(accessibilityProvider);
    final totalProducts = Utils.getTotalProduct(order);
    final language = Utils.languages[ref.watch(languageProvider)];
    ref.listen(orderProvider, (prev, next) {
      if (next.rows.isEmpty) {
        Navigator.pop(context);
      }
    });

    return InactivityTimer(
      child: Scaffold(
        body: LayoutBuilder(
          builder: (context, raint) {
            return Column(
              children: [
                Header(
                  leading:
                      accessibility ? SizedBox() : BackBtn(language: language),
                  trailing: accessibility
                      ? SizedBox()
                      : ClearButton(language: language),
                ),
                Semicircle(),
                accessibility
                    ? Spacer(
                        flex: 2,
                      )
                    : SizedBox(),
                Text(
                  language['orderRecapScreen']['title'],
                  style: TextStyle(
                      fontFamily: GoogleFonts.courgette().fontFamily,
                      fontSize: ResponsiveText.title(context),
                      color: MyColors.colorSecondary,
                      fontWeight: FontWeight.bold),
                ),
                Text(
                  (language['orderRecapScreen']['description'] as String)
                      .replaceAll("{}", order.rows.length.toString()),
                  style: TextStyle(
                      fontSize: ResponsiveText.title(context),
                      color: MyColors.colorText,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: accessibility ? 40 : 0,
                ),
                !accessibility
                    ? SizedBox()
                    : Text(
                        language['orderRecapScreen']['total'],
                        style: TextStyle(
                            fontFamily: GoogleFonts.courgette().fontFamily,
                            fontSize: ResponsiveText.title(context),
                            color: MyColors.colorSecondary,
                            fontWeight: FontWeight.bold),
                      ),
                !accessibility
                    ? SizedBox()
                    : AnimatedFlipCounter(
                        prefix: "€ ",
                        fractionDigits: 2,
                        value: Utils.getTotalPrice(order.rows),
                        textStyle: TextStyle(
                            fontSize: ResponsiveText.title(context),
                            color: MyColors.colorText,
                            fontWeight: FontWeight.bold),
                      ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 35, vertical: 15),
                    child: GridView.builder(
                      scrollDirection:
                          accessibility ? Axis.horizontal : Axis.vertical,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: accessibility ? 1 : 2,
                        mainAxisSpacing: accessibility ? 1 : 30,
                        childAspectRatio: accessibility ? 0.6 : 1.5,
                        crossAxisSpacing: accessibility ? 1 : 10,
                      ),
                      itemCount: totalProducts.length,
                      itemBuilder: (context, index) => ProductCard(
                        product: totalProducts[index],
                        isRecap: true,
                      ),
                    ),
                  ),
                ),
                accessibility
                    ? SizedBox()
                    : Text(
                        language['orderRecapScreen']['total'],
                        style: TextStyle(
                            fontFamily: GoogleFonts.courgette().fontFamily,
                            fontSize: ResponsiveText.title(context),
                            color: MyColors.colorSecondary,
                            fontWeight: FontWeight.bold),
                      ),
                accessibility
                    ? SizedBox()
                    : AnimatedFlipCounter(
                        prefix: "€ ",
                        fractionDigits: 2,
                        value: Utils.getTotalPrice(order.rows),
                        textStyle: TextStyle(
                            fontSize: ResponsiveText.title(context),
                            color: MyColors.colorText,
                            fontWeight: FontWeight.bold),
                      ),
                accessibility
                    ? SizedBox(
                        height: 10,
                      )
                    : SizedBox(
                        height: 30,
                      ),
                Row(
                  children: [
                    Spacer(),
                    SizedBox(
                      width: accessibility ? 20 : 0,
                    ),
                    Expanded(
                      flex: 2,
                      child: FilledButton(
                        style: FilledButton.styleFrom(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(10),
                                    bottomRight: Radius.circular(30),
                                    topLeft: Radius.circular(30),
                                    topRight: Radius.circular(10))),
                            padding: EdgeInsets.symmetric(
                                horizontal: 40, vertical: 25),
                            backgroundColor: MyColors.colorText),
                        onPressed: order.rows.isNotEmpty
                            ? () =>
                                Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => PaymentScreen(),
                                ))
                            : null,
                        child: Text(
                          language['orderRecapScreen']['payment'],
                          style: TextStyle(
                            color: MyColors.colorBackground,
                            fontSize: ResponsiveText.title(context),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: accessibility ? 20 : 0,
                    ),
                    accessibility ? Expanded(child: LanguagePopup()) : Spacer(),
                  ],
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 40, vertical: 40),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      accessibility
                          ? Expanded(
                              child: BackBtn(
                                language: language,
                              ),
                            )
                          : Spacer(),
                      SizedBox(
                        width: 25,
                      ),
                      Expanded(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: MyColors.colorText,
                            fixedSize: Size(
                              MediaQuery.of(context).size.width * 0.25,
                              MediaQuery.of(context).size.width * 0.05,
                            ),
                          ),
                          onPressed: () {
                            ref
                                .read(accessibilityProvider.notifier)
                                .changeAccessibility(!accessibility);
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
                                  language['orderRecapScreen']
                                      ['accessibility_text'],
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: MyColors.colorBackground,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 25,
                      ),
                      accessibility
                          ? Expanded(
                              child: ClearButton(language: language),
                            )
                          : Spacer(),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
