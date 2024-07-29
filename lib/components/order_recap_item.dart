import 'package:badges/badges.dart' as badges;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:totem/components/extra_popup.dart';
import 'package:totem/components/remove_list_popup.dart';
import 'package:totem/models/product_item.dart';
import 'package:totem/providers/order_provider.dart';

class OrderRecapItem extends ConsumerWidget {
  final ProductItem product;
  const OrderRecapItem({super.key, required this.product});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final orderNotifier = ref.read(orderProvider.notifier);
    final order = ref.watch(orderProvider);
    return badges.Badge(
      badgeAnimation: const badges.BadgeAnimation.rotation(),
      position: badges.BadgePosition.topEnd(end: 0, top: -15),
      badgeStyle: const badges.BadgeStyle(
          badgeColor: Colors.green,
          borderSide: BorderSide(color: Colors.white)),
      badgeContent: Text(
          orderNotifier.getItemCount(product.productId).toString(),
          style: const TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18)),
      child: LayoutBuilder(builder: (context, constraint) {
        return Container(
          height: constraint.maxHeight,
          decoration: BoxDecoration(
              boxShadow: const [
                BoxShadow(blurRadius: 10, color: Color(0x33000000))
              ],
              borderRadius: BorderRadius.circular(20),
              color: const Color(0xFFF1EAE2)),
          child: Flex(
            direction: Axis.horizontal,
            children: [
              Flexible(
                  child: ClipRRect(
                      borderRadius: const BorderRadius.horizontal(
                          left: Radius.circular(20)),
                      child: Image.asset(
                        product.image!,
                        height: constraint.maxHeight,
                        fit: BoxFit.cover,
                      ))),
              Flexible(
                  flex: 2,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          product.name,
                          softWrap: false,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              fontFamily: GoogleFonts.courgette().fontFamily,
                              fontWeight: FontWeight.bold,
                              color: const Color(0xFF907676)),
                        ),
                        const Spacer(),
                        Align(
                          alignment: Alignment.centerRight,
                          child: FilledButton(
                              style: FilledButton.styleFrom(
                                  shape: const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.only(
                                          bottomLeft: Radius.circular(5),
                                          bottomRight: Radius.circular(20),
                                          topLeft: Radius.circular(20),
                                          topRight: Radius.circular(5))),
                                  backgroundColor: const Color(0xFF907676),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 10)),
                              onPressed: () =>
                                  orderNotifier.addItem(product.productId),
                              child: const Text(
                                "AGGIUNGI",
                                style: TextStyle(
                                    fontSize: 12, color: Colors.white),
                              )),
                        ),
                        const SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            FilledButton(
                                style: FilledButton.styleFrom(
                                    shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.only(
                                            bottomLeft: Radius.circular(5),
                                            topLeft: Radius.circular(20))),
                                    backgroundColor: const Color(0xCCC3ABA4),
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 5, vertical: 5)),
                                onPressed: () => showDialog(
                                        context: context,
                                        builder: (context) => ExtraPopup(
                                            rows: ref.read(orderProvider).rows,
                                            startIndex: order.rows.indexWhere(
                                                (element) =>
                                                    element.productId ==
                                                    product.productId))).then(
                                      (value) {
                                        if (value == null) return;
                                        orderNotifier.updateVariant(value);
                                      },
                                    ),
                                child: const FaIcon(FontAwesomeIcons.pen,
                                    size: 15, color: Color(0xFF907676))),
                            FilledButton(
                                style: FilledButton.styleFrom(
                                    shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.only(
                                            bottomRight: Radius.circular(20),
                                            topRight: Radius.circular(5))),
                                    backgroundColor: const Color(0x55C3ABA4),
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 15, vertical: 10)),
                                onPressed: () => showDialog(
                                    context: context,
                                    builder: (context) =>
                                        RemoveListPopup(product: product)),
                                child: const FaIcon(FontAwesomeIcons.trash,
                                    size: 15, color: Color(0xFF907676))),
                          ],
                        ),
                      ],
                    ),
                  ))
            ],
          ),
        );
      }),
    );
  }
}
