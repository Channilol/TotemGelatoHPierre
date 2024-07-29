import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:totem/components/inactivity_timer.dart';
import 'package:totem/models/extra_item.dart';
import 'package:totem/models/order_item.dart';
import 'package:totem/models/product_item.dart';
import 'package:totem/providers/order_provider.dart';
import 'package:totem/services/my_colors.dart';
import 'package:totem/services/utils.dart';

class DeletePopupItem extends ConsumerStatefulWidget {
  const DeletePopupItem(
      {super.key, required this.product, required this.orderRow});
  final ProductItem product;
  final OrderRowItem orderRow;

  @override
  ConsumerState<DeletePopupItem> createState() => _DeletePopupItemState();
}

class _DeletePopupItemState extends ConsumerState<DeletePopupItem> {
  @override
  Widget build(BuildContext context) {
    List<ExtraItem> extraItemsList = Utils.extras;
    String extrasString = "";
    if (widget.orderRow.extras!.isNotEmpty) {
      String extraString = "";
      for (var i = 0; i < widget.orderRow.extras!.length; i++) {
        var extra = extraItemsList
            .firstWhere((e) => e.extraId == widget.orderRow.extras![i].extraId);
        extraString += extra.description + ", ";
      }
      extrasString = extraString.substring(0, extraString.length - 2);
    }
    var itemQty = ref
        .watch(orderProvider.notifier)
        .getItemRowsCount(widget.product.productId);

    return InactivityTimer(
      child: Container(
        height: MediaQuery.of(context).size.height * 0.07,
        padding: EdgeInsets.symmetric(
          horizontal: 30.0,
        ),
        margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
        decoration: const BoxDecoration(
          color: MyColors.colorContainer,
          borderRadius: BorderRadius.only(
            bottomRight: Radius.circular(16),
            topLeft: Radius.circular(16),
          ),
        ),
        child: Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${widget.product.name}',
                    style: TextStyle(fontSize: 20.0),
                  ),
                  Text(
                      'Extra: ${widget.orderRow.extras!.isEmpty ? 'No' : extrasString}'),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    onPressed: () {
                      ref
                          .read(orderProvider.notifier)
                          .removeOrder(widget.orderRow.rowId);
                    },
                    icon: const Icon(
                      FontAwesomeIcons.trash,
                      color: MyColors.colorText,
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
