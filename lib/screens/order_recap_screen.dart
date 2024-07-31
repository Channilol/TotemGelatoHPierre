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
                  leading: accessibility
                      ? SizedBox()
                      : BackButton(language: language),
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
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 35, vertical: 15),
                    child: GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: 30,
                          childAspectRatio: 1.5,
                          crossAxisSpacing: 10),
                      itemCount: totalProducts.length,
                      itemBuilder: (context, index) => ProductCard(
                        product: totalProducts[index],
                        isRecap: true,
                      ),
                    ),
                  ),
                ),
                Text(
                  language['orderRecapScreen']['total'],
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
                accessibility
                    ? SizedBox(
                        height: 10,
                      )
                    : SizedBox(
                        height: 30,
                      ),
                FilledButton(
                  style: FilledButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(10),
                              bottomRight: Radius.circular(30),
                              topLeft: Radius.circular(30),
                              topRight: Radius.circular(10))),
                      padding:
                          EdgeInsets.symmetric(horizontal: 40, vertical: 25),
                      backgroundColor: MyColors.colorText),
                  onPressed: order.rows.isNotEmpty
                      ? () => Navigator.of(context).push(MaterialPageRoute(
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
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 40, vertical: 40),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
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

//TODO: DA SPOSTARE IN UN FILE A PARTE

class ClearButton extends ConsumerWidget {
  const ClearButton({
    super.key,
    required this.language,
  });

  final Map language;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 5.0),
      child: FilledButton(
        style: FilledButton.styleFrom(
          shape: RoundedRectangleBorder(
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
              builder: (context) => ClearOrderPopup()).then((value) {
            if (value == null) return;
            ref.read(orderProvider.notifier).setOrder(OrderItem(rows: []));
            Navigator.pop(context);
          });
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            FaIcon(
              FontAwesomeIcons.xmark,
              color: MyColors.colorBackground,
              size: 18,
            ),
            Text(language['orderRecapScreen']['clear'],
                style: TextStyle(
                    color: MyColors.colorBackground,
                    fontFamily: GoogleFonts.nunito().fontFamily,
                    fontSize: ResponsiveText.large(context)))
          ],
        ),
      ),
    );
  }
}

class BackButton extends ConsumerWidget {
  const BackButton({
    super.key,
    required this.language,
  });

  final Map language;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 8.0),
      child: FilledButton(
        style: FilledButton.styleFrom(
            shape: RoundedRectangleBorder(
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
            Text(language['orderRecapScreen']['back'],
                style: TextStyle(
                    color: MyColors.colorText,
                    fontFamily: GoogleFonts.nunito().fontFamily,
                    fontSize: ResponsiveText.large(context)))
          ],
        ),
      ),
    );
  }
}

                // if (!accessibility) ...[
                //  
                //   Expanded(
                //     child: Padding(
                //       padding: EdgeInsets.all(10.0),
                //       child: GridView.builder(
                //           gridDelegate:
                //               SliverGridDelegateWithFixedCrossAxisCount(
                //                   crossAxisCount: 2,
                //                   mainAxisSpacing: 30,
                //                   childAspectRatio: 1.5,
                //                   crossAxisSpacing: 10),
                //           itemCount: totalProducts.length,
                //           itemBuilder: (context, index) => ProductCard(
                //                 product: totalProducts[index],
                //                 isRecap: true,
                //               )),
                //     ),
                //   ),
                //   Text(
                //     language['orderRecapScreen']['total'],
                //     style: TextStyle(
                //         fontFamily: GoogleFonts.courgette().fontFamily,
                //         fontSize: ResponsiveText.huge(context),
                //         color: MyColors.colorSecondary,
                //         fontWeight: FontWeight.bold),
                //   ),
                //   AnimatedFlipCounter(
                //     prefix: "€ ",
                //     fractionDigits: 2,
                //     value: Utils.getTotalPrice(order.rows),
                //     textStyle: TextStyle(
                //         fontSize: ResponsiveText.huge(context),
                //         color: MyColors.colorText,
                //         fontWeight: FontWeight.bold),
                //   ),
                //   Row(
                //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //     children: [
                //       Expanded(
                //         child: ElevatedButton(
                //           style: ElevatedButton.styleFrom(
                //             backgroundColor: MyColors.colorText,
                //           ),
                //           onPressed: () {
                //             ref
                //                 .read(accessibilityProvider.notifier)
                //                 .changeAccessibility(!accessibility);
                //           },
                //           child: Padding(
                //             padding: EdgeInsets.symmetric(
                //               horizontal: 20,
                //               vertical: 10,
                //             ),
                //             child: Row(
                //               mainAxisAlignment: MainAxisAlignment.center,
                //               children: [
                //                 FaIcon(FontAwesomeIcons.universalAccess),
                //                 SizedBox(
                //                   width: 7.5,
                //                 ),
                //                 Text(
                //                   language['orderRecapScreen']
                //                       ['accessibility_text'],
                //                   style: TextStyle(
                //                     fontSize: 18,
                //                     color: MyColors.colorBackground,
                //                   ),
                //                 ),
                //               ],
                //             ),
                //           ),
                //         ),
                //       ),
                //       SizedBox(width: 20),
                //       Expanded(
                //         child: FilledButton(
                //           style: FilledButton.styleFrom(
                //               shape: RoundedRectangleBorder(
                //                   borderRadius: BorderRadius.only(
                //                       bottomLeft: Radius.circular(10),
                //                       bottomRight: Radius.circular(30),
                //                       topLeft: Radius.circular(30),
                //                       topRight: Radius.circular(10))),
                //               padding: EdgeInsets.symmetric(
                //                   horizontal: 40, vertical: 25),
                //               backgroundColor: MyColors.colorText),
                //           onPressed: order.rows.isNotEmpty
                //               ? () =>
                //                   Navigator.of(context).push(MaterialPageRoute(
                //                     builder: (context) => PaymentScreen(),
                //                   ))
                //               : null,
                //           child: Text(
                //             language['orderRecapScreen']['payment'],
                //             style: TextStyle(
                //               color: MyColors.colorBackground,
                //               fontSize: ResponsiveText.huge(context),
                //             ),
                //           ),
                //         ),
                //       ),
                //       Expanded(child: Spacer()),
                //     ],
                //   ),
                //   SizedBox(width: 20),
                // ] else ...[
                //   Expanded(
                //     flex: 2,
                //     child: SizedBox(),
                //   ),
                //   Text(
                //     (language['orderRecapScreen']['description'] as String)
                //         .replaceAll("{}", order.rows.length.toString()),
                //     style: TextStyle(
                //         fontSize: ResponsiveText.huge(context),
                //         color: MyColors.colorText,
                //         fontWeight: FontWeight.bold),
                //   ),
                //   Text(
                //     language['orderRecapScreen']['total'],
                //     style: TextStyle(
                //         fontFamily: GoogleFonts.courgette().fontFamily,
                //         fontSize: ResponsiveText.huge(context),
                //         color: MyColors.colorSecondary,
                //         fontWeight: FontWeight.bold),
                //   ),
                //   AnimatedFlipCounter(
                //     prefix: "€ ",
                //     fractionDigits: 2,
                //     value: Utils.getTotalPrice(order.rows),
                //     textStyle: TextStyle(
                //         fontSize: ResponsiveText.huge(context),
                //         color: MyColors.colorText,
                //         fontWeight: FontWeight.bold),
                //   ),
                //   Expanded(
                //     child: SizedBox(
                //       height: MediaQuery.of(context).size.height * 0.45,
                //       width: MediaQuery.of(context).size.width,
                //       child: ListView.builder(
                //         scrollDirection: Axis.horizontal,
                //         itemCount: totalProducts.length,
                //         itemBuilder: (context, index) =>
                //             OrderRecapItem(product: totalProducts[index]),
                //       ),
                //     ),
                //   ),
                //   SizedBox(
                //     height: 20,
                //   ),
                //   Row(
                //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //     children: [
                //       Expanded(
                //         child: ElevatedButton(
                //           style: ElevatedButton.styleFrom(
                //             backgroundColor: MyColors.colorText,
                //           ),
                //           onPressed: () {
                //             ref
                //                 .read(accessibilityProvider.notifier)
                //                 .changeAccessibility(!accessibility);
                //           },
                //           child: Padding(
                //             padding: EdgeInsets.symmetric(
                //               horizontal: 20,
                //               vertical: 10,
                //             ),
                //             child: Row(
                //               mainAxisAlignment: MainAxisAlignment.center,
                //               children: [
                //                 FaIcon(FontAwesomeIcons.universalAccess),
                //                 SizedBox(
                //                   width: 7.5,
                //                 ),
                //                 Text(
                //                   language['orderRecapScreen']
                //                       ['accessibility_text'],
                //                   style: TextStyle(
                //                     fontSize: 18,
                //                     color: MyColors.colorBackground,
                //                   ),
                //                 ),
                //               ],
                //             ),
                //           ),
                //         ),
                //       ),
                //       Expanded(
                //         child: FilledButton(
                //           style: FilledButton.styleFrom(
                //               shape: RoundedRectangleBorder(
                //                   borderRadius: BorderRadius.only(
                //                       bottomLeft: Radius.circular(10),
                //                       bottomRight: Radius.circular(30),
                //                       topLeft: Radius.circular(30),
                //                       topRight: Radius.circular(10))),
                //               padding: EdgeInsets.symmetric(
                //                   horizontal: 40, vertical: 25),
                //               backgroundColor: MyColors.colorText),
                //           onPressed: order.rows.isNotEmpty
                //               ? () =>
                //                   Navigator.of(context).push(MaterialPageRoute(
                //                     builder: (context) => PaymentScreen(),
                //                   ))
                //               : null,
                //           child: Text(
                //             language['orderRecapScreen']['payment'],
                //             style: TextStyle(
                //                 color: MyColors.colorBackground,
                //                 fontSize: ResponsiveText.large(context)),
                //           ),
                //         ),
                //       ),
                //       Expanded(child: LanguagePopup())
                //     ],
                //   ),
                //   SizedBox(height: 20),
                //   Container(
                //     height: MediaQuery.of(context).size.height * 0.07,
                //     color: MyColors.colorContainer,
                //     child: Row(
                //       mainAxisAlignment: MainAxisAlignment.spaceAround,
                //       children: [
                //         Spacer(),
                //         Expanded(
                //           flex: 2,
                //           child: Padding(
                //             padding: EdgeInsets.symmetric(
                //                 horizontal: 8.0, vertical: 20.0),
                //             child: FilledButton(
                //               style: FilledButton.styleFrom(
                //                   shape: RoundedRectangleBorder(
                //                       borderRadius: BorderRadius.only(
                //                           bottomLeft: Radius.circular(5),
                //                           bottomRight: Radius.circular(20),
                //                           topLeft: Radius.circular(20),
                //                           topRight: Radius.circular(5))),
                //                   backgroundColor: MyColors.colorBackground),
                //               onPressed: () => Navigator.pop(context),
                //               child: Row(
                //                 mainAxisAlignment:
                //                     MainAxisAlignment.spaceEvenly,
                //                 children: [
                //                   Icon(
                //                     Icons.arrow_back_ios_new_rounded,
                //                     color: MyColors.colorText,
                //                     size: 18,
                //                   ),
                //                   Text(language['orderRecapScreen']['back'],
                //                       style: TextStyle(
                //                           color: MyColors.colorText,
                //                           fontFamily:
                //                               GoogleFonts.nunito().fontFamily,
                //                           fontSize:
                //                               ResponsiveText.large(context)))
                //                 ],
                //               ),
                //             ),
                //           ),
                //         ),
                //         Spacer(),
                //         Expanded(
                //           flex: 2,
                //           child: Padding(
                //             padding: EdgeInsets.symmetric(
                //                 horizontal: 10.0, vertical: 20.0),
                //             child: FilledButton(
                //                 style: FilledButton.styleFrom(
                //                   shape: RoundedRectangleBorder(
                //                       borderRadius: BorderRadius.only(
                //                           bottomLeft: Radius.circular(5),
                //                           bottomRight: Radius.circular(20),
                //                           topLeft: Radius.circular(20),
                //                           topRight: Radius.circular(5))),
                //                   backgroundColor: MyColors.colorText,
                //                 ),
                //                 onPressed: () {
                //                   showDialog(
                //                       barrierDismissible: false,
                //                       context: context,
                //                       builder: (context) =>
                //                           ClearOrderPopup()).then((value) {
                //                     if (value == null) return;
                //                     ref
                //                         .read(orderProvider.notifier)
                //                         .setOrder(OrderItem(rows: []));
                //                     Navigator.pop(context);
                //                   });
                //                 },
                //                 child: Row(
                //                   mainAxisAlignment:
                //                       MainAxisAlignment.spaceEvenly,
                //                   children: [
                //                     FaIcon(
                //                       FontAwesomeIcons.xmark,
                //                       color: MyColors.colorBackground,
                //                       size: 18,
                //                     ),
                //                     Text(language['orderRecapScreen']['clear'],
                //                         style: TextStyle(
                //                             color: MyColors.colorBackground,
                //                             fontFamily:
                //                                 GoogleFonts.nunito().fontFamily,
                //                             fontSize:
                //                                 ResponsiveText.large(context)))
                //                   ],
                //                 )),
                //           ),
                //         ),
                //         Spacer(),
                //       ],
                //     ),
                //   ),
                // ]