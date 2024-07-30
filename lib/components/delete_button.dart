import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:totem/components/delete_popup.dart';
import 'package:totem/components/inactivity_timer.dart';
import 'package:totem/models/order_item.dart';
import 'package:totem/models/product_item.dart';
import 'package:totem/providers/order_provider.dart';

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
    var orderRows = ref.watch(orderProvider)?.rows;
    bool doExtraExist = false;
    var itemQty = ref
        .watch(orderProvider.notifier)
        .getItemRowsCount(widget.product.productId);
    List<OrderRowItem>? orderItemsByProduct = ref
        .watch(orderProvider)
        ?.rows
        .where((e) => e.productId == widget.product.productId)
        .toList();
    for (var i = 0; i < orderItemsByProduct!.length; i++) {
      if (orderItemsByProduct[i].extras!.isNotEmpty) {
        doExtraExist = true;
      }
    }

    return Transform.translate(
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
            onPressed: doExtraExist == true
                ? () {
                    showDialog(
                      barrierDismissible: false,
                      context: context,
                      builder: (context) =>
                          DeletePopup(product: widget.product),
                    );
                  }
                : () {
                    widget.orderNotifier.removeItem(widget.product.productId);
                  },
            child: Text("CANCELLA",
                style: TextStyle(
                    fontFamily: GoogleFonts.nunito().fontFamily,
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFF907676),
                    fontSize: 10))),
      ),
    );
  }
}
