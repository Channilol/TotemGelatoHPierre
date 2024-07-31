import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:totem/components/animated_filp_number.dart';
import 'package:totem/components/clear_order_popup.dart';
import 'package:totem/components/header.dart';
import 'package:totem/components/inactivity_timer.dart';
import 'package:totem/components/language_popup.dart';
import 'package:totem/components/order_recap_item.dart';
import 'package:totem/models/order_item.dart';
import 'package:totem/providers/accessibility_provider.dart';
import 'package:totem/providers/language_provider.dart';
import 'package:totem/providers/order_provider.dart';
import 'package:totem/screens/payment_screen.dart';
import 'package:totem/services/my_colors.dart';
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
          builder: (context, constraint) {
            return Column(
              children: [
                !accessibility
                    ? Header(
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
                                Icon(
                                  Icons.arrow_back_ios_new_rounded,
                                  color: MyColors.colorText,
                                  size: 18,
                                ),
                                Text(language['orderRecapScreen']['back'],
                                    style: TextStyle(
                                        color: MyColors.colorText,
                                        fontFamily:
                                            GoogleFonts.nunito().fontFamily,
                                        fontSize: 14))
                              ],
                            ),
                          ),
                        ),
                        trailing: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 5.0),
                          child: FilledButton(
                              style: FilledButton.styleFrom(
                                shape: const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.only(
                                        bottomLeft: Radius.circular(5),
                                        bottomRight: Radius.circular(20),
                                        topLeft: Radius.circular(20),
                                        topRight: Radius.circular(5))),
                                backgroundColor: MyColors.colorText,
                              ),
                              onPressed: () {
                                showDialog(
                                    barrierDismissible: false,
                                    context: context,
                                    builder: (context) =>
                                        const ClearOrderPopup()).then((value) {
                                  if (value == null) return;
                                  ref
                                      .read(orderProvider.notifier)
                                      .setOrder(OrderItem(rows: []));
                                  Navigator.pop(context);
                                });
                              },
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  const FaIcon(
                                    FontAwesomeIcons.xmark,
                                    color: Colors.white,
                                    size: 18,
                                  ),
                                  Text(language['orderRecapScreen']['clear'],
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontFamily:
                                              GoogleFonts.nunito().fontFamily,
                                          fontSize: 14))
                                ],
                              )),
                        ),
                      )
                    : Header(),
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
                if (!accessibility) ...[
                  const SizedBox(height: 20),
                  Text(
                    language['orderRecapScreen']['title'],
                    style: TextStyle(
                        fontFamily: GoogleFonts.courgette().fontFamily,
                        fontSize: 25,
                        color: const Color(0xFFC3ABA4),
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    (language['orderRecapScreen']['description'] as String)
                        .replaceAll("{}", order.rows.length.toString()),
                    style: TextStyle(
                        fontSize: 30,
                        color: MyColors.colorText,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: GridView.builder(
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  mainAxisSpacing: 30,
                                  childAspectRatio: 1.5,
                                  crossAxisSpacing: 10),
                          itemCount: totalProducts.length,
                          itemBuilder: (context, index) =>
                              OrderRecapItem(product: totalProducts[index])),
                    ),
                  ),
                  Text(
                    language['orderRecapScreen']['total'],
                    style: TextStyle(
                        fontFamily: GoogleFonts.courgette().fontFamily,
                        fontSize: 25,
                        color: const Color(0xFFC3ABA4),
                        fontWeight: FontWeight.bold),
                  ),
                  AnimatedFlipCounter(
                    prefix: "€ ",
                    fractionDigits: 2,
                    value: Utils.getTotalPrice(order.rows),
                    textStyle: TextStyle(
                        fontSize: 30,
                        color: MyColors.colorText,
                        fontWeight: FontWeight.bold),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          IconButton(
                            onPressed: () {
                              ref
                                  .read(accessibilityProvider.notifier)
                                  .changeAccessibility(!accessibility);
                            },
                            icon: Icon(FontAwesomeIcons.universalAccess),
                            color: MyColors.colorText,
                          ),
                          Text(
                            language['orderRecapScreen']['accessibility_text'],
                            style: TextStyle(color: MyColors.colorText),
                          ),
                        ],
                      ),
                      FilledButton(
                          style: FilledButton.styleFrom(
                              shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.only(
                                      bottomLeft: Radius.circular(10),
                                      bottomRight: Radius.circular(30),
                                      topLeft: Radius.circular(30),
                                      topRight: Radius.circular(10))),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 40, vertical: 25),
                              backgroundColor: MyColors.colorText),
                          onPressed: order.rows.isNotEmpty
                              ? () =>
                                  Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => const PaymentScreen(),
                                  ))
                              : null,
                          child: Text(language['orderRecapScreen']['payment'],
                              style: TextStyle(
                                  color: Colors.white, fontSize: 25))),
                      LanguagePopup(),
                    ],
                  ),
                  const SizedBox(height: 20),
                ] else ...[
                  Expanded(flex: 2, child: SizedBox()),
                  Expanded(
                    child: SizedBox(
                      height: MediaQuery.of(context).size.height * 0.4,
                      width: MediaQuery.of(context).size.width,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: totalProducts.length,
                        itemBuilder: (context, index) =>
                            OrderRecapItem(product: totalProducts[index]),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          IconButton(
                            onPressed: () {
                              ref
                                  .read(accessibilityProvider.notifier)
                                  .changeAccessibility(!accessibility);
                            },
                            icon: Icon(FontAwesomeIcons.universalAccess),
                            color: MyColors.colorText,
                          ),
                          Text(
                            language['orderRecapScreen']['accessibility_text'],
                            style: TextStyle(color: MyColors.colorText),
                          ),
                        ],
                      ),
                      FilledButton(
                        style: FilledButton.styleFrom(
                            shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(10),
                                    bottomRight: Radius.circular(30),
                                    topLeft: Radius.circular(30),
                                    topRight: Radius.circular(10))),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 40, vertical: 25),
                            backgroundColor: MyColors.colorText),
                        onPressed: order.rows.isNotEmpty
                            ? () =>
                                Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => const PaymentScreen(),
                                ))
                            : null,
                        child: Text(
                          language['orderRecapScreen']['payment'],
                          style: TextStyle(color: Colors.white, fontSize: 25),
                        ),
                      ),
                      LanguagePopup()
                    ],
                  ),
                  const SizedBox(height: 20),
                  Container(
                    height: MediaQuery.of(context).size.height * 0.05,
                    color: MyColors.colorContainer,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Padding(
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
                                Icon(
                                  Icons.arrow_back_ios_new_rounded,
                                  color: MyColors.colorText,
                                  size: 18,
                                ),
                                Text(language['orderRecapScreen']['back'],
                                    style: TextStyle(
                                        color: MyColors.colorText,
                                        fontFamily:
                                            GoogleFonts.nunito().fontFamily,
                                        fontSize: 14))
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 5.0),
                          child: FilledButton(
                            style: FilledButton.styleFrom(
                              shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.only(
                                      bottomLeft: Radius.circular(5),
                                      bottomRight: Radius.circular(20),
                                      topLeft: Radius.circular(20),
                                      topRight: Radius.circular(5))),
                              backgroundColor: MyColors.colorText,
                            ),
                            onPressed: () {
                              showDialog(
                                  barrierDismissible: false,
                                  context: context,
                                  builder: (context) =>
                                      const ClearOrderPopup()).then((value) {
                                if (value == null) return;
                                ref
                                    .read(orderProvider.notifier)
                                    .setOrder(OrderItem(rows: []));
                                Navigator.pop(context);
                              });
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                const FaIcon(
                                  FontAwesomeIcons.xmark,
                                  color: Colors.white,
                                  size: 18,
                                ),
                                Text(language['orderRecapScreen']['clear'],
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontFamily:
                                            GoogleFonts.nunito().fontFamily,
                                        fontSize: 14))
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ]
              ],
            );
          },
        ),
      ),
    );
  }
}
