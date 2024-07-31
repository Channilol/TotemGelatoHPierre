import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:totem/components/delete_popup.dart';
import 'package:totem/models/order_item.dart';
import 'package:totem/models/product_item.dart';
import 'package:totem/providers/accessibility_provider.dart';
import 'package:totem/providers/language_provider.dart';
import 'package:totem/providers/order_provider.dart';
import 'package:totem/services/my_colors.dart';
import 'package:totem/services/text.dart';
import 'package:totem/services/utils.dart';

class DeleteButton extends ConsumerStatefulWidget {
  const DeleteButton({
    super.key,
    required this.orderNotifier,
    required this.product,
  });

  final OrderProvider orderNotifier;
  final ProductItem product;

  @override
  ConsumerState<DeleteButton> createState() => _DeleteButtonState();
}

class _DeleteButtonState extends ConsumerState<DeleteButton> {
  @override
  Widget build(BuildContext context) {
    bool doExtraExist = false;

    List<OrderRowItem>? orderItemsByProduct = ref
        .watch(orderProvider)
        .rows
        .where((e) => e.productId == widget.product.productId)
        .toList();
    for (var i = 0; i < orderItemsByProduct.length; i++) {
      if (orderItemsByProduct[i].extras!.isNotEmpty) {
        doExtraExist = true;
      }
    }
    final isAccessibilityOn = ref.watch(accessibilityProvider);

    return Transform.translate(
      offset: const Offset(5, 0),
      child: FilledButton(
        style: FilledButton.styleFrom(
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(3),
                    topLeft: Radius.circular(16))),
            backgroundColor: const Color(0xAAC3ABA4),
            padding: isAccessibilityOn
                ? EdgeInsets.symmetric(horizontal: 20, vertical: 20)
                : EdgeInsets.symmetric(horizontal: 40, vertical: 20)),
        onPressed: doExtraExist == true
            ? () {
                if (isAccessibilityOn) {
                  showModalBottomSheet(
                    context: context,
                    builder: (context) => DeletePopup(product: widget.product),
                  );
                } else {
                  showDialog(
                    context: context,
                    builder: (context) =>
                        Dialog(child: DeletePopup(product: widget.product)),
                  );
                }
              }
            : () {
                widget.orderNotifier.removeItem(widget.product.productId);
              },
        child: Text(
          Utils.languages[ref.watch(languageProvider)]['orderScreen']
              ['Product_button_text_remove'],
          style: TextStyle(
            fontFamily: GoogleFonts.nunito().fontFamily,
            fontWeight: FontWeight.bold,
            color: MyColors.colorText,
            fontSize: ResponsiveText.medium(context),
          ),
        ),
      ),
    );
  }
}
