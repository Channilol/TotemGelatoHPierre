import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:totem/components/animated_filp_number.dart';
import 'package:totem/components/language_popup.dart';
import 'package:totem/components/product_card.dart';
import 'package:totem/providers/accessibility_provider.dart';
import 'package:totem/providers/category_provider.dart';
import 'package:totem/providers/language_provider.dart';
import 'package:totem/providers/order_provider.dart';
import 'package:totem/screens/order_recap_screen.dart';
import 'package:totem/services/my_colors.dart';
import 'package:totem/services/utils.dart';

class ProductList extends ConsumerWidget {
  const ProductList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentCategory = Utils.categories[ref.watch(categoryProvider)];
    final order = ref.watch(orderProvider);
    final language = Utils.languages[ref.watch(languageProvider)];
    final isAccessibilityOn = ref.watch(accessibilityProvider);
    return Column(
      children: [
        isAccessibilityOn
            ? Spacer(
                flex: 3,
              )
            : SizedBox(),
        Expanded(
          child: Stack(
            children: [
              ListView(
                scrollDirection:
                    isAccessibilityOn ? Axis.horizontal : Axis.vertical,
                children: [
                  ...Utils.products
                      .where((product) =>
                          product.categoryId == currentCategory.categoryId)
                      .map((product) => ProductCard(product: product)),
                  const SizedBox(
                    height: 50,
                  )
                ],
              ),
              isAccessibilityOn
                  ? SizedBox()
                  : Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        height: 100.0, // Altezza della sfumatura
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Color.fromARGB(0, 255, 255, 255),
                              MyColors.colorBackground, // Colore di sfondo
                            ],
                          ),
                        ),
                      ),
                    ),
            ],
          ),
        ),
        isAccessibilityOn
            ? Container(
                height: 90,
                color: MyColors.colorContainer,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      height: 65,
                      width: MediaQuery.of(context).size.width * 0.2,
                      decoration: BoxDecoration(
                          color: MyColors.colorBackground,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(5),
                            topRight: Radius.circular(20),
                            bottomLeft: Radius.circular(20),
                            bottomRight: Radius.circular(5),
                          )),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          AnimatedFlipCounter(
                            value: order.rows.length,
                            suffix:
                                " ${language['orderScreen']['button_top_left']}",
                            textStyle: const TextStyle(fontSize: 20),
                          ),
                          AnimatedFlipCounter(
                            value: Utils.getTotalPrice(order.rows),
                            prefix: "€ ",
                            fractionDigits: 2,
                            textStyle: TextStyle(
                                color: MyColors.colorText,
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                    ),
                    GestureDetector(
                      onTap: () => order.rows.isNotEmpty
                          ? Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => OrderRecapScreen()))
                          : null,
                      child: AnimatedContainer(
                        height: 65,
                        width: MediaQuery.of(context).size.width * 0.2,
                        duration: const Duration(milliseconds: 500),
                        decoration: BoxDecoration(
                            color: Color.fromRGBO(
                                144, 118, 118, order.rows.isNotEmpty ? 1 : 0.7),
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(20),
                              topRight: Radius.circular(5),
                              bottomLeft: Radius.circular(5),
                              bottomRight: Radius.circular(20),
                            )),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(language['orderScreen']['button_top_right_1'],
                                style: TextStyle(
                                    color: MyColors.colorBackground,
                                    fontSize: 20,
                                    letterSpacing: 0)),
                            Text(
                              language['orderScreen']['button_top_right_2'],
                              style: TextStyle(
                                  color: MyColors.colorBackground,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 0,
                                  fontSize: 20),
                            )
                          ],
                        ),
                      ),
                    ),
                    LanguagePopup(),
                  ],
                ),
              )
            : SizedBox(),
      ],
    );
  }
}
