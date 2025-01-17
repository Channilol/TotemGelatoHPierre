import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:totem/components/delete_popup_item.dart';
import 'package:totem/components/inactivity_timer.dart';
import 'package:totem/models/order_item.dart';
import 'package:totem/models/product_item.dart';
import 'package:totem/providers/accessibility_provider.dart';
import 'package:totem/providers/language_provider.dart';
import 'package:totem/providers/order_provider.dart';
import 'package:totem/services/my_colors.dart';
import 'package:totem/services/text.dart';
import 'package:totem/services/utils.dart';

class DeletePopup extends ConsumerStatefulWidget {
  const DeletePopup({super.key, required this.product});
  final ProductItem product;

  @override
  ConsumerState<DeletePopup> createState() => _DeletePopupState();
}

class _DeletePopupState extends ConsumerState<DeletePopup> {
  @override
  Widget build(BuildContext context) {
    final language = Utils.languages[ref.watch(languageProvider)];
    final isAccessibilityOn = ref.watch(accessibilityProvider);
    var orderRows = ref.watch(orderProvider).rows;
    List<OrderRowItem> filteredOrdersByProduct = [];
    if (orderRows.isNotEmpty) {
      filteredOrdersByProduct = orderRows
          .where((e) => e.productId == widget.product.productId)
          .toList();
    }
    List<Widget> extrasCard = [];
    for (var i = 0; i < filteredOrdersByProduct.length; i++) {
      extrasCard.add(
        DeletePopupItem(
            product: widget.product, orderRow: filteredOrdersByProduct[i]),
      );
    }

    var itemQty = ref
        .watch(orderProvider.notifier)
        .getItemRowsCount(widget.product.productId);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (itemQty < 1) {
        debugPrint('pop');
        if (mounted) {
          Navigator.pop(context);
        }
      }
    });

    return InactivityTimer(
      child: LayoutBuilder(
        builder: (context, constraints) {
          double maxHeight = constraints.maxHeight;
          double maxWidth = constraints.maxWidth;
          return Container(
            height: maxHeight * (isAccessibilityOn ? 0.5 : 0.4),
            width: maxWidth * (isAccessibilityOn ? 1.0 : 0.7),
            padding: EdgeInsets.symmetric(vertical: 25),
            decoration: BoxDecoration(
              color: MyColors.colorBackground,
              borderRadius: BorderRadius.circular(12.0),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                  padding: EdgeInsets.only(bottom: 25),
                  child: Text(
                    language['orderRecapScreen']['removeItemDialogTitle'],
                    style: TextStyle(
                      color: MyColors.colorText,
                      fontSize: ResponsiveText.huge(context) + 6,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Expanded(
                  child: ListView(
                    children: extrasCard,
                    padding: EdgeInsets.symmetric(horizontal: 20),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
