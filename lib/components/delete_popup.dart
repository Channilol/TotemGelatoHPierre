import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:totem/components/delete_popup_item.dart';
import 'package:totem/components/inactivity_timer.dart';
import 'package:totem/models/order_item.dart';
import 'package:totem/models/product_item.dart';
import 'package:totem/providers/order_provider.dart';
import 'package:totem/services/my_colors.dart';

class DeletePopup extends ConsumerStatefulWidget {
  const DeletePopup({super.key, required this.product});
  final ProductItem product;

  @override
  ConsumerState<DeletePopup> createState() => _DeletePopupState();
}

class _DeletePopupState extends ConsumerState<DeletePopup> {
  @override
  Widget build(BuildContext context) {
    var orderRows = ref.watch(orderProvider)?.rows;
    List<OrderRowItem> filteredOrdersByProduct = [];
    if (orderRows!.isNotEmpty) {
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

    return InactivityTimer(
      child: Dialog(
        backgroundColor: Colors.transparent,
        child: LayoutBuilder(
          builder: (context, constraints) {
            double maxHeight = constraints.maxHeight;
            double maxWidth = constraints.maxWidth;
            return Container(
              height: maxHeight * 0.7,
              width: maxWidth * 0.7,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12.0),
              ),
              child: Card(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    const Text(
                      'Quale gelato vuoi cancellare?',
                      style: TextStyle(
                        color: MyColors.colorText,
                        fontSize: 25.0,
                      ),
                    ),
                    Expanded(
                      child: ListView(
                        children: extrasCard,
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
