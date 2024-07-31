import 'package:badges/badges.dart' as badges;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:totem/models/product_item.dart';
import 'package:totem/providers/accessibility_provider.dart';
import 'package:totem/providers/language_provider.dart';
import 'package:totem/providers/order_provider.dart';
import 'package:totem/services/my_colors.dart';
import 'package:totem/services/text.dart';
import 'package:totem/services/utils.dart';

class AddButton extends ConsumerWidget {
  const AddButton({
    super.key,
    required this.productCount,
    required this.orderNotifier,
    required this.product,
    this.isRecap = false,
  });

  final int productCount;
  final OrderProvider orderNotifier;
  final ProductItem product;
  final bool isRecap;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final language = Utils.languages[ref.watch(languageProvider)];
    final isAccessibilityOn = ref.watch(accessibilityProvider);
    return badges.Badge(
      badgeAnimation: const badges.BadgeAnimation.rotation(
          animationDuration: Duration(milliseconds: 200)),
      badgeStyle: badges.BadgeStyle(
        padding: EdgeInsets.all(14),
        borderSide: BorderSide(color: MyColors.colorBackground, width: 4),
        badgeColor: Color.fromARGB(255, 0, 178, 6),
      ),
      badgeContent: Text(
        productCount.toString(),
        style: TextStyle(
          color: MyColors.colorBackground,
          fontWeight: FontWeight.bold,
          fontSize: ResponsiveText.small(context),
        ),
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
              backgroundColor: MyColors.colorText,
              padding: const EdgeInsets.all(15)),
          onPressed: () => orderNotifier.addItem(product.productId),
          child: Container(
            padding: isAccessibilityOn
                ? EdgeInsets.symmetric(
                    horizontal: MediaQuery.of(context).size.width *
                        (isRecap ? 0.005 : 0.02),
                    vertical: MediaQuery.of(context).size.width *
                        (isRecap ? 0.0025 : 0.01),
                  )
                : EdgeInsets.symmetric(
                    horizontal: MediaQuery.of(context).size.width *
                        (isRecap ? 0.01 : 0.04),
                    vertical: MediaQuery.of(context).size.width *
                        (isRecap ? 0.005 : 0.02),
                  ),
            child: Column(
              children: [
                Text(
                  "€ ${product.price.toStringAsFixed(2)}",
                  style: TextStyle(
                      fontSize: isAccessibilityOn
                          ? isRecap
                              ? ResponsiveText.medium(context)
                              : ResponsiveText.large(context)
                          : isRecap
                              ? ResponsiveText.large(context)
                              : ResponsiveText.huge(context),
                      fontWeight: FontWeight.bold,
                      color: MyColors.colorBackground),
                ),
                Text(
                  language['orderScreen']['Product_button_text_add'],
                  style: TextStyle(
                    color: MyColors.colorBackground,
                    fontSize: isAccessibilityOn
                        ? isRecap
                            ? ResponsiveText.medium(context)
                            : ResponsiveText.large(context)
                        : isRecap
                            ? ResponsiveText.large(context)
                            : ResponsiveText.huge(context),
                  ),
                )
              ],
            ),
          )),
    );
  }
}
