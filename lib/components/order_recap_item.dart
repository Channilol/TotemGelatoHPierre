import 'package:badges/badges.dart' as badges;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:totem/components/delete_popup.dart';
import 'package:totem/components/dialog_wrapper.dart';
import 'package:totem/components/extra_popup.dart';
import 'package:totem/models/order_item.dart';
import 'package:totem/models/product_item.dart';
import 'package:totem/providers/accessibility_provider.dart';
import 'package:totem/providers/language_provider.dart';
import 'package:totem/providers/order_provider.dart';
import 'package:totem/services/my_colors.dart';
import 'package:totem/services/text.dart';
import 'package:totem/services/utils.dart';

class OrderRecapItem extends ConsumerWidget {
  final ProductItem product;
  const OrderRecapItem({super.key, required this.product});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final orderNotifier = ref.read(orderProvider.notifier);
    final order = ref.watch(orderProvider);
    final language = Utils.languages[ref.watch(languageProvider)];
    var orderRows = ref.watch(orderProvider).rows;
    var isAccessibilityOn = ref.watch(accessibilityProvider);
    bool doExtraExist = false;
    var itemQty =
        ref.watch(orderProvider.notifier).getItemRowsCount(product.productId);
    List<OrderRowItem>? orderItemsByProduct = ref
        .watch(orderProvider)
        .rows
        .where((e) => e.productId == product.productId)
        .toList();
    for (var i = 0; i < orderItemsByProduct.length; i++) {
      if (orderItemsByProduct[i].extras!.isNotEmpty) {
        doExtraExist = true;
      }
    }

    return Padding(
      padding: EdgeInsets.all(10.0),
      child: badges.Badge(
        badgeAnimation: badges.BadgeAnimation.rotation(),
        position: badges.BadgePosition.topEnd(end: 0, top: -15),
        badgeStyle: badges.BadgeStyle(
            badgeColor: Colors.green,
            borderSide: BorderSide(color: Colors.white)),
        badgeContent: Text(
            orderNotifier.getItemCount(product.productId).toString(),
            style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: ResponsiveText.medium(context))),
        child: LayoutBuilder(builder: (context, raint) {
          return Container(
            height: raint.maxHeight,
            width: isAccessibilityOn ? 500 : raint.maxWidth,
            decoration: BoxDecoration(
                boxShadow: const [
                  BoxShadow(blurRadius: 10, color: Color(0x33000000))
                ],
                borderRadius: BorderRadius.circular(20),
                color: Color(0xFFF1EAE2)),
            child: Row(
              //direction: Axis.horizontal,
              children: [
                Expanded(
                    child: ClipRRect(
                        borderRadius:
                            BorderRadius.horizontal(left: Radius.circular(20)),
                        child: Image.asset(
                          product.image!,
                          height: raint.maxHeight,
                          fit: BoxFit.cover,
                        ))),
                Expanded(
                    flex: 2,
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
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
                                color: MyColors.colorText,
                                fontSize: ResponsiveText.huge(context)),
                          ),
                          Spacer(),
                          Align(
                            alignment: Alignment.centerRight,
                            child: FilledButton(
                                style: FilledButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.only(
                                            bottomLeft: Radius.circular(5),
                                            bottomRight: Radius.circular(20),
                                            topLeft: Radius.circular(20),
                                            topRight: Radius.circular(5))),
                                    backgroundColor: MyColors.colorText,
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 20, vertical: 10)),
                                onPressed: () =>
                                    orderNotifier.addItem(product.productId),
                                child: Text(
                                  language['orderRecapScreen']['card']['add'],
                                  style: TextStyle(
                                      fontSize: ResponsiveText.large(context),
                                      color: Colors.white),
                                )),
                          ),
                          SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              FilledButton(
                                  style: FilledButton.styleFrom(
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.only(
                                              bottomLeft: Radius.circular(5),
                                              topLeft: Radius.circular(20))),
                                      backgroundColor: Color(0xCCC3ABA4),
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 5, vertical: 5)),
                                  onPressed: () {
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
                                  },
                                  child: FaIcon(FontAwesomeIcons.pen,
                                      size: 15, color: Color(0xFF907676))),
                              FilledButton(
                                  style: FilledButton.styleFrom(
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.only(
                                              bottomRight: Radius.circular(20),
                                              topRight: Radius.circular(5))),
                                      backgroundColor: Color(0x55C3ABA4),
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 15, vertical: 10)),
                                  onPressed: doExtraExist == true
                                      ? () {
                                          if (isAccessibilityOn) {
                                            showModalBottomSheet(
                                              context: context,
                                              builder: (context) =>
                                                  DeletePopup(product: product),
                                            );
                                          } else {
                                            showDialog(
                                              context: context,
                                              builder: (context) => Dialog(
                                                  child: DeletePopup(
                                                      product: product)),
                                            );
                                          }
                                        }
                                      : () {
                                          orderNotifier
                                              .removeItem(product.productId);
                                        },
                                  child: FaIcon(FontAwesomeIcons.trash,
                                      size: 15, color: MyColors.colorText)),
                            ],
                          ),
                        ],
                      ),
                    ))
              ],
            ),
          );
        }),
      ),
    );
  }
}
