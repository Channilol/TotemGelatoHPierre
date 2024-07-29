import 'package:badges/badges.dart' as badges;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:totem/components/extra_popup.dart';
import 'package:totem/components/inactivity_timer.dart';
import 'package:totem/models/product_item.dart';
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
    return Container(
        height: cardHeight,
        margin: const EdgeInsets.only(bottom: 10),
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.horizontal(left: Radius.circular(20)),
          color: Color(0xFFF1EAE2),
        ),
        child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
          SizedBox(
            width: 100,
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
                                ? () => showDialog(
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
                                    )
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
                          Transform.translate(
                            offset: const Offset(5, 0),
                            child: InactivityTimer(
                              child: FilledButton(
                                  style: FilledButton.styleFrom(
                                      shape: const RoundedRectangleBorder(
                                          borderRadius: BorderRadius.only(
                                              bottomLeft: Radius.circular(5),
                                              topLeft: Radius.circular(20))),
                                      backgroundColor: const Color(0xAAC3ABA4),
                                      padding: const EdgeInsets.all(10)),
                                  onPressed: () {
                                    orderNotifier.removeItem(product.productId);
                                  },
                                  child: Text("CANCELLA",
                                      style: TextStyle(
                                          fontFamily:
                                              GoogleFonts.nunito().fontFamily,
                                          fontWeight: FontWeight.bold,
                                          color: const Color(0xFF907676),
                                          fontSize: 10))),
                            ),
                          ),
                        badges.Badge(
                          badgeAnimation: const badges.BadgeAnimation.rotation(
                              animationDuration: Duration(milliseconds: 200)),
                          badgeStyle: const badges.BadgeStyle(
                              badgeColor: Colors.green,
                              borderSide: BorderSide(color: Colors.white)),
                          badgeContent: Text(
                            productCount.toString(),
                            style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                          showBadge: productCount > 0,
                          child: FilledButton(
                              style: FilledButton.styleFrom(
                                  shape: const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.only(
                                          bottomLeft: Radius.circular(5),
                                          bottomRight: Radius.circular(20),
                                          topLeft: Radius.circular(20),
                                          topRight: Radius.circular(5))),
                                  backgroundColor: const Color(0xFF907676),
                                  padding: const EdgeInsets.all(15)),
                              onPressed: () =>
                                  orderNotifier.addItem(product.productId),
                              child: Column(
                                children: [
                                  Text(
                                    "€ ${product.price.toStringAsFixed(2)}",
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white),
                                  ),
                                  const Text(
                                    "AGGIUNGI",
                                    style: TextStyle(color: Colors.white),
                                  )
                                ],
                              )),
                        ),
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
