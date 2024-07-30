import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:totem/components/add_button.dart';
import 'package:totem/components/delete_button.dart';
import 'package:totem/components/dialog_wrapper.dart';
import 'package:totem/components/extra_popup.dart';
import 'package:totem/components/inactivity_timer.dart';
import 'package:totem/models/product_item.dart';
import 'package:totem/providers/accessibility_provider.dart';
import 'package:totem/providers/order_provider.dart';

class ProductCard extends ConsumerWidget {
  final ProductItem product;
  const ProductCard({super.key, required this.product});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cardHeight = MediaQuery.of(context).size.height * .25;
    final order = ref.watch(orderProvider);
    final orderNotifier = ref.read(orderProvider.notifier);
    final productCount = order.rows
        .where((element) => element.productId == product.productId)
        .length;
    final isAccessibilityOn = ref.watch(accessibilityProvider);

    return Container(
        height: cardHeight,
        width: isAccessibilityOn ? 400 : double.infinity,
        margin: isAccessibilityOn
            ? EdgeInsets.only(right: 10, bottom: 10)
            : EdgeInsets.only(bottom: 10),
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.horizontal(left: Radius.circular(20)),
          color: Color(0xFFF1EAE2),
        ),
        child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
          SizedBox(
            width: 150,
            child: ClipRRect(
                borderRadius:
                    const BorderRadius.horizontal(left: Radius.circular(20)),
                child: Image.asset(
                  product.image!,
                  height: cardHeight,
                  fit: BoxFit.cover,
                )),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          product.name,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              fontFamily: GoogleFonts.courgette().fontFamily,
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                              color: const Color(0xFF907676)),
                        ),
                      ),
                      InactivityTimer(
                        child: IconButton(
                            onPressed: productCount > 0
                                ? () {
                                    if (isAccessibilityOn) {
                                      showModalBottomSheet(
                                          context: context,
                                          builder: (context) => ExtraPopup(
                                              rows: order.rows
                                                  .where((element) =>
                                                      element.productId ==
                                                      product.productId)
                                                  .toList())).then(
                                        (value) {
                                          if (value == null) return;
                                          orderNotifier.updateVariant(value);
                                        },
                                      );
                                      return;
                                    }
                                    showDialog(
                                        context: context,
                                        builder: (context) => DialogWrapper(
                                              child: ExtraPopup(
                                                  rows: order.rows
                                                      .where((element) =>
                                                          element.productId ==
                                                          product.productId)
                                                      .toList()),
                                            )).then(
                                      (value) {
                                        if (value == null) return;
                                        orderNotifier.updateVariant(value);
                                      },
                                    );
                                  }
                                : null,
                            icon: FaIcon(FontAwesomeIcons.pen,
                                size: 15,
                                color: productCount > 0
                                    ? const Color(0xFF907676)
                                    : Colors.grey)),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Text(
                    product.description,
                    softWrap: true,
                    style: const TextStyle(color: Color(0xFF907676)),
                  ),
                  const Spacer(),
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        if (productCount > 0)
                          DeleteButton(
                              orderNotifier: orderNotifier, product: product),
                        AddButton(
                            productCount: productCount,
                            orderNotifier: orderNotifier,
                            product: product),
                      ],
                    ),
                  )
                ],
              ),
            ),
          )
        ]));
  }
}
