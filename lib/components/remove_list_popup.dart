import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:totem/components/inactivity_timer.dart';
import 'package:totem/models/order_item.dart';
import 'package:totem/models/product_item.dart';
import 'package:totem/providers/order_provider.dart';
import 'package:totem/services/utils.dart';

class RemoveListPopup extends ConsumerStatefulWidget {
  final ProductItem product;
  const RemoveListPopup({super.key, required this.product});

  @override
  ConsumerState<RemoveListPopup> createState() => _RemoveListPopupState();
}

class _RemoveListPopupState extends ConsumerState<RemoveListPopup> {
  @override
  Widget build(BuildContext context) {
    final order = ref.watch(orderProvider);
    return InactivityTimer(
      child: Dialog(
          child: ListView(
              children: order.rows
                  .where((el) => el.productId == widget.product.productId)
                  .map((el) => row(el))
                  .toList())),
    );
  }

  Widget row(OrderRowItem item) {
    final orderNotifier = ref.read(orderProvider.notifier);
    return Dismissible(
        onDismissed: (direction) => orderNotifier.removeRow(item),
        key: UniqueKey(),
        child: ListTile(
            leading: widget.product.image == null
                ? null
                : Image.asset(widget.product.image!, width: 40, height: 40),
            subtitle: Column(
                children:
                    (item.extras ?? []).map((el) => extraItem(el)).toList()),
            trailing: IconButton(
              icon: const FaIcon(FontAwesomeIcons.trash, size: 15),
              onPressed: () => orderNotifier.removeRow(item),
            )));
  }

  Widget extraItem(OrderExtraItem extraRow) {
    final extra =
        Utils.extras.firstWhere((el) => el.extraId == extraRow.extraId);
    return Text("+ ${extra.price} ${extra.description}");
  }
}
